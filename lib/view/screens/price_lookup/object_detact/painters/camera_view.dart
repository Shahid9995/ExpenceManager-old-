import 'dart:io';

import 'package:camera/camera.dart';
import 'package:expensemanage_app/core/repository/MyRepo.dart';
import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/primary_button.dart';
import 'package:expensemanage_app/view/screens/price_lookup/object_detact/productPriceList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/api/api_client.dart';
import '../../../../../core/repository/UserRepo.dart';
import '../../../../../core/viewModel/controller/userdatacontroller/user_data_controller.dart';
import '../../../../../main.dart';
import '../../../../base/custom_snackbar.dart';



enum ScreenMode { liveFeed, gallery }

class CameraView extends StatefulWidget {
  const CameraView(
      {Key? key,
        required this.title,
        required this.customPaint,
        this.text,
        required this.onImage,
        this.onScreenModeChanged,
        this.initialDirection = CameraLensDirection.back})
      : super(key: key);

  final String title;
  final CustomPaint? customPaint;
  final String? text;
  final Function(InputImage inputImage) onImage;
  final Function(ScreenMode mode)? onScreenModeChanged;
  final CameraLensDirection initialDirection;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  ScreenMode _mode = ScreenMode.liveFeed;
  CameraController? _controller;
  File? _image;
  String? _path;
  ImagePicker? _imagePicker;
  int _cameraIndex = 0;
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;
  final bool _allowPicker = true;
  bool _changingCameraLens = false;
  UserDataController userDataController = UserDataController(userRepo: UserRepo(ApiClient()));

  @override
  void initState() {
    super.initState();

    _imagePicker = ImagePicker();

    if (cameras.any(
          (element) =>
      element.lensDirection == widget.initialDirection &&
          element.sensorOrientation == 90,
    )) {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere((element) =>
        element.lensDirection == widget.initialDirection &&
            element.sensorOrientation == 90),
      );
    } else {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere(
              (element) => element.lensDirection == widget.initialDirection,
        ),
      );
    }

    _startLiveFeed();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kAppbarColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:AppColors.kAppbarColor ,
        // foregroundColor: AppColors.kAppbarColor,
        title: Text(widget.title),
        // actions: [
        //   if (_allowPicker)
        //     Padding(
        //       padding: const EdgeInsets.only(right: 20.0),
        //       child: GestureDetector(
        //         onTap: _switchScreenMode,
        //         child: Icon(
        //           _mode == ScreenMode.liveFeed
        //               ? Icons.photo_library_outlined
        //               : (Platform.isIOS
        //               ? Icons.camera_alt_outlined
        //               : Icons.camera),
        //         ),
        //       ),
        //     ),
        // ],
      ),
      body:_body(),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget? _floatingActionButton() {
    // if (_mode == ScreenMode.gallery) return null;
    // if (cameras.length == 1) return null;
    return
      (userDataController.isLoading)?const Padding(
        padding:  EdgeInsets.symmetric(vertical: 10),
        child: CircularProgressIndicator(),
      ):
      InkWell(
      onTap: () async {
        print("===at camera view:${MyRepo.tittle.value.length}===========");
        if(MyRepo.tittle.value!=""){
         // await _stopLiveFeed();
         //  await _controller?.stopImageStream();
           _stopLiveFeed();
          // await _controller?.dispose();
          await userDataController.googleSearch(MyRepo.tittle.value).then((status) async {
            print("=login body=status:${status.isSuccess}==");
            if (status.isSuccess) {
              Get.off(()=> const PriceList());
            }else{
              showCustomSnackBar(status.message);
              _startLiveFeed();
            }
          });

        }else{
          _startLiveFeed();
        }
      },
        child: const SizedBox(
            height: 50.0,
              // width: 70.0,
            child: PrimaryButton(text: "Scan")));
      // SizedBox(
      //   height: 60.0,
      //   width: 100.0,
      //   child: FloatingActionButton(
      //     shape: BeveledRectangleBorder(
      //         borderRadius: BorderRadius.circular(30)
      //     ),
      //     child:Text("Scane"),
      //     // Icon(
      //     //   Platform.isIOS
      //     //       ? Icons.flip_camera_ios_outlined
      //     //       : Icons.flip_camera_android_outlined,
      //     //   size: 40,
      //     // ),
      //     onPressed: _stopLiveFeed,
      //     // onPressed: _switchLiveCamera,
      //   ));
  }

  Widget _body() {
    Widget body;
    if (_mode == ScreenMode.liveFeed) {
      body = _liveFeedBody();
    } else {
      body = _galleryBody();
    }
    return body;
  }

  Widget _liveFeedBody() {
    if (_controller?.value.isInitialized == false) {
      return Container();
    }

    final size = MediaQuery.of(context).size;
    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * _controller!.value.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Transform.scale(
            scale: scale,
            child: Center(
              child:
              _changingCameraLens
                  ? const Center(
                child: Text('Changing camera lens'),
              )
                  :
              CameraPreview(_controller!),
            ),
          ),
          if (widget.customPaint != null) widget.customPaint!,
          Positioned(
            bottom: 100,
            left: 50,
            right: 50,
            child: Slider(
              value: zoomLevel,
              min: minZoomLevel,
              max: maxZoomLevel,
              onChanged: (newSliderValue) {
                setState(() {
                  // print("======SHAHID1:$newSliderValue========");
                  zoomLevel = newSliderValue;
                  _controller!.setZoomLevel(zoomLevel);
                });
              },
              divisions: (maxZoomLevel - 1).toInt() < 1
                  ? null
                  : (maxZoomLevel - 1).toInt(),
            ),
          )
        ],
      ),
    );
  }

  Widget _galleryBody() {
    return ListView(shrinkWrap: true, children: [
      _image != null
          ? SizedBox(
        height: 400,
        width: 400,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.file(_image!),
            if (widget.customPaint != null) widget.customPaint!,
          ],
        ),
      )
          : const Icon(
        Icons.image,
        size: 200,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          child: const Text('From Gallery'),
          onPressed: () => _getImage(ImageSource.gallery),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          child: const Text('Take a picture'),
          onPressed: () => _getImage(ImageSource.camera),
        ),
      ),
      if (_image != null)
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
              '${_path == null ? '' : 'Image path: $_path'}\n\n${widget.text ?? ''}'),
        ),
    ]);
  }

  Future _getImage(ImageSource source) async {
    setState(() {
      _image = null;
      _path = null;
    });
    final pickedFile = await _imagePicker?.pickImage(source: source);
    if (pickedFile != null) {
      _processPickedFile(pickedFile);
    }
    setState(() {});
  }

  // void _switchScreenMode() {
  //   _image = null;
  //   if (_mode == ScreenMode.liveFeed) {
  //     _mode = ScreenMode.gallery;
  //     _stopLiveFeed();
  //   } else {
  //     _mode = ScreenMode.liveFeed;
  //     _startLiveFeed();
  //   }
  //   if (widget.onScreenModeChanged != null) {
  //     widget.onScreenModeChanged!(_mode);
  //   }
  //   setState(() {});
  // }

  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        zoomLevel = value;
        minZoomLevel = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        maxZoomLevel = value;
      });
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {

    // print("=========shahid:==================");

    await _controller?.stopImageStream();
    // await _stopLiveFeed();
    await _controller?.dispose();
    _controller = null;
  }

  Future _switchLiveCamera() async {
    setState(() => _changingCameraLens = true);
    _cameraIndex = (_cameraIndex + 1) % cameras.length;

    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  Future _processPickedFile(XFile? pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      return;
    }
    setState(() {
      _image = File(path);
    });
    _path = path;
    final inputImage = InputImage.fromFilePath(path);
    widget.onImage(inputImage);
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
    Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation =
    InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    if (imageRotation == null) return;

    final inputImageFormat =
    InputImageFormatValue.fromRawValue(image.format.raw);
    if (inputImageFormat == null) return;

    final planeData = image.planes.map(
          (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage = InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    widget.onImage(inputImage);
  }
}
