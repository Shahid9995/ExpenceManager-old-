import 'dart:io';
import 'dart:io' as io;

import 'package:camera/camera.dart';
import 'package:expensemanage_app/core/viewModel/Scaffold/AppScafflod.dart';
import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/view/screens/price_lookup/object_detact/painters/camera_view.dart';
import 'package:expensemanage_app/view/screens/price_lookup/object_detact/painters/object_detacter_painters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/api/api_client.dart';
import '../../../core/repository/UserRepo.dart';
import '../../../core/viewModel/controller/userdatacontroller/user_data_controller.dart';
import '../../../util/primary_button.dart';
import 'object_detact/object_detacter_view.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({Key? key}) : super(key: key);

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  UserDataController userDataController = UserDataController(userRepo: UserRepo(ApiClient()));
    File? _image;
  late ObjectDetector _objectDetector;
  bool _canProcess = false;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  CameraController? _controller;
  @override
  void initState() {
    super.initState();

    _initializeDetector(DetectionMode.stream);
  }

  @override
  void dispose() {
    _stopLiveFeed();
    _canProcess = false;
    _objectDetector.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AppScafflod(
        heading: "Price Lookup",
        body: Expanded(
          child: Container(
            color: AppColors.kAppbarColor,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      // height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: AppSizes.appHorizontalSm),
                      decoration: const BoxDecoration(
                          color: AppColors.kWhite,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: AppSizes.appHorizontalMd,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.kGrayText,
                                borderRadius: BorderRadius.circular(10)),
                            height: 4,
                            width: 100,
                          ),
                          SizedBox(
                            height: AppSizes.appHorizontalSm * 2,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Scan Product",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppSizes.appHorizontalSm * 2),
                                ),
                                  // Expanded(
                                  //   child: Container(
                                  //     // height: 450,
                                  //     color: Colors.white,
                                  //     child: CameraView(
                                  //       title: 'Object Detector',
                                  //       customPaint: _customPaint,
                                  //       text: _text,
                                  //       onImage: (inputImage) {
                                  //         processImage(inputImage);
                                  //       },
                                  //       onScreenModeChanged: _onScreenModeChanged,
                                  //       initialDirection: CameraLensDirection.back,
                                  //     ),
                                  //   ),
                                  // ),
                                (!userDataController.isLoading)
                                    ? Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: InkWell(
                                    onTap: (){
                                      print("===============");
                                      // _stopLiveFeed();
                                      // Get.offAll(RouteHelper.getDashboardRoute());
                                      Get.to(()=>const ObjectDetectorView());
                                    },
                                      // onTap: () {
                                      //   (_image != null)
                                      //       ?Get.to(()=>AddProductDetails(img: _image,))
                                      //   // _saveReceipt(userDataController)
                                      //       : showModalBottomSheet(
                                      //       context: context,
                                      //       builder: (BuildContext
                                      //       context) {
                                      //         return Wrap(
                                      //           children: [
                                      //             InkWell(
                                      //               onTap: () {
                                      //                 pickImage(ImageSource.gallery);
                                      //                 Navigator.pop(
                                      //                     context);
                                      //                 print(
                                      //                     "=====gallery============");
                                      //               },
                                      //               child:
                                      //               const ListTile(
                                      //                 leading: Icon(
                                      //                     FontAwesomeIcons
                                      //                         .images),
                                      //                 title: Text(
                                      //                     "Gallery"),
                                      //               ),
                                      //             ),
                                      //             InkWell(
                                      //               onTap: ()  {
                                      //                 pickImage(ImageSource.camera);
                                      //                 Navigator.pop(context);
                                      //                 print(
                                      //                     "=====camera============");
                                      //               },
                                      //               child:
                                      //               const ListTile(
                                      //                 leading: Icon(
                                      //                     FontAwesomeIcons
                                      //                         .camera),
                                      //                 title: Text(
                                      //                     "Camera"),
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         );
                                      //       });
                                      // },
                                      child: PrimaryButton(
                                        text: (_image != null)
                                            ? "Save"
                                            : 'Scan',
                                      )),
                                )
                                    : const Center(
                                    child: CircularProgressIndicator()),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ));
  }
  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      print("=Image=${image.path}==============");
      setState(() {
        this._image = File(image.path);
      });
    } else {}
  }
  void _onScreenModeChanged(ScreenMode mode) {
    switch (mode) {
      case ScreenMode.gallery:
        _initializeDetector(DetectionMode.single);
        return;

      case ScreenMode.liveFeed:
        _initializeDetector(DetectionMode.stream);
        return;
    }
  }

  void _initializeDetector(DetectionMode mode) async {
    print('Set detector in mode: $mode');

    // uncomment next lines if you want to use the default model
    // final options = ObjectDetectorOptions(
    //     mode: mode,
    //     classifyObjects: true,
    //     multipleObjects: true);
    // _objectDetector = ObjectDetector(options: options);

    // uncomment next lines if you want to use a local model
    // make sure to add tflite model to assets/ml
    const path = 'assets/ml/object_labeler.tflite';
    final modelPath = await _getModel(path);
    final options = LocalObjectDetectorOptions(
      mode: mode,
      modelPath: modelPath,
      classifyObjects: true,
      multipleObjects: true,
    );
    _objectDetector = ObjectDetector(options: options);

    // uncomment next lines if you want to use a remote model
    // make sure to add model to firebase
    // final modelName = 'bird-classifier';
    // final response =
    //     await FirebaseObjectDetectorModelManager().downloadModel(modelName);
    // print('Downloaded: $response');
    // final options = FirebaseObjectDetectorOptions(
    //   mode: mode,
    //   modelName: modelName,
    //   classifyObjects: true,
    //   multipleObjects: true,
    // );
    // _objectDetector = ObjectDetector(options: options);

    _canProcess = true;
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final objects = await _objectDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = ObjectDetectorPainter(
          objects,
          inputImage.inputImageData!.imageRotation,
          inputImage.inputImageData!.size);
      _customPaint = CustomPaint(painter: painter);
    } else {
      print("=========shahid:==================");
      String text = 'Objects found: ${objects.length}\n\n';
      for (final object in objects) {
        text += 'Object:  trackingId: ${object.trackingId} - ${object.labels.map((e) => e.text)}\n\n';
        print("shahid=:${object.labels.map((e) => e.index)}");
        print("${object.labels.map((e) => e.text)}");
        print("${object.labels.map((e) => e.confidence)}");

      }
      // Text("========");
      _text = text;
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
  Future _stopLiveFeed() async {print("==_controller:${ _controller?.dispose()}=");
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }
  Future<String> _getModel(String assetPath) async {
    if (io.Platform.isAndroid) {
      return 'flutter_assets/$assetPath';
    }
    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    await io.Directory(dirname(path)).create(recursive: true);
    final file = io.File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }
}
