import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';

import '../../util/app_constants.dart';
import '../response/error_response.dart';

class ApiClient extends GetxService {
   // final String appBaseUrl;

  static const String noInternetMessage = 'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 60;
  late String token;
  // ApiClient({@required this.appBaseUrl,})
  // {
  //   token = sharedPreferences.getString(AppConstants.TOKEN);
  //   debugPrint('Token: $token');
  //   updateHeader(token, sharedPreferences.getString(AppConstants.LANGUAGE_CODE));
  // }

  // void updateHeader(String token, String languageCode) {
  //   _mainHeaders = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     AppConstants.LOCALIZATION_KEY: languageCode ?? AppConstants.languages[0].languageCode,
  //     'Authorization': 'Bearer $token'
  //   };
  // }

  // Future<Response> getData(String uri, {Map<String, dynamic> query, Map<String, String> headers}) async {
  //   try {
  //     debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
  //     Http.Response _response = await Http.get(
  //       Uri.parse(appBaseUrl+uri),
  //       headers: headers ?? _mainHeaders,
  //     ).timeout(Duration(seconds: timeoutInSeconds));
  //     return handleResponse(_response, uri);
  //   } catch (e) {
  //     return Response(statusCode: 1, statusText: noInternetMessage);
  //   }
  // }

  Future<Response> postData(String uri, dynamic body, ) async {
    try {
      debugPrint('====> API Call: $uri');
      debugPrint('====> API Body: $body');
      Http.Response _response = await Http.post(
        Uri.parse(AppConstants.BASE_URL+uri),
        body: body,
        // body:{
        //   "name":"pen",
        //   // "email":"kamranabrar90@gmail.com",
        //   // "password":"12345678",
        // },
      ).timeout(Duration(seconds: timeoutInSeconds));
      print("====postData._response:${_response.body}===========");
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
  Future<Response> getData(String uri,) async {
    try {
      debugPrint('====> API Call: $uri');
      Http.Response _response = await Http.get(
        Uri.parse(AppConstants.BASE_URL+uri),
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
  Future<Response> postMultipartData(String uri, Map<String, String> body, List<MultipartBody> multipartBody,) async {
    try {
      debugPrint('====> API Call: $uri');
      debugPrint('====> API Body: $body');
      Http.MultipartRequest _request = Http.MultipartRequest('POST', Uri.parse(AppConstants.BASE_URL+uri));
      for(MultipartBody multipart in multipartBody) {
        if(multipart.file != null) {
            File _file = File(multipart.file.path);
            _request.files.add(Http.MultipartFile(
              multipart.key, _file.readAsBytes().asStream(), _file.lengthSync(), filename: _file.path.split('/').last,
            ));
        }
      }
      _request.fields.addAll(body);
      Http.Response _response = await Http.Response.fromStream(await _request.send());
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    }catch(e) {}
    Response _response = Response(
      body: _body != null ? _body : response.body,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if(_response.statusCode != 200 && _response.body != null && _response.body is !String) {
      if(_response.body.toString().startsWith('{errors: [{code:')) {
        // debugPrint('====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.errors[0].message);
      }else if(_response.body.toString().startsWith('{message')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
      }
    }else if(_response.statusCode != 200 && _response.body == null) {
      _response =  Response(statusCode: 0, statusText: noInternetMessage);
      debugPrint('====> API Response: [${_response.statusText}] $uri\n${_response.body}');
    }
    // _response=Response(statusText: _response.statusText,body:{_response.body} );
    debugPrint('====> API Response: [${_response.statusCode}] $uri \n${_response.body}');
    return _response;
  }
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}