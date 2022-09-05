import 'dart:convert';
import 'dart:developer';

import 'package:dating_app/api/config/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class CustomInterCeptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // String temporaryToken =
    //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9tZmxpcC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2NDEyODU0OTMsImV4cCI6MTY0MTM3MTg5MywibmJmIjoxNjQxMjg1NDkzLCJqdGkiOiJuSEpQaENmM25HbVNENklYIiwic3ViIjoyNywicHJ2IjoiZjUyNmFmMTg4MmU5NDU2YzFiNjJhNTM0YWIwMzk4MTQyZmNhZTU5NSJ9.XMDWLQOrPY9sBzrSG7vcndFIUW22hVjvqRYSY8ZegRs';

    // if (sharedPreferences.containsKey(key_user_token)) {
    // String _user_Token = Utils.getPref(key_user_token)!;
    // log("user token " + _user_Token);
    // String username = 'domnic';
    // String password = '12345678';
    log("Username = $username   +   Password = $password");
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));
    print("oildhoidsh" + basicAuth);
    options.headers = {
      'authorization': basicAuth

      // base64.encode(utf8.encode('"domnic":"12345678"'))
      // "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsIm5hbWUiOiJBZG1pbiIsImlhdCI6MTY2MTYyMjcyMiwiZXhwIjoxODE5MzAyNzIyfQ.PFxMmPLtJgxeyu38eAUUKWl_GFelluuVKLlnrlWJMYY"
    };
    // }

    // print(user_Token);
    // options.headers = {'Authorization': "Bearer ${temporaryToken}"};
    super.onRequest(options, handler);
  }
}

class DioClient {
  Dio _dio = Dio(BaseOptions(
    baseUrl: Base_url,
  ))
    ..interceptors.add(CustomInterCeptor());
  Future<dynamic> getRequest({
    required String apiEnd,
    Map<String, dynamic>? queryParameter,
    //  option
  }) async {
    try {
      //  log("heder  " + option.toString());
      final res = await _dio.get(
        apiEnd,
        queryParameters: queryParameter,
        // options: Options(headers: option)
      );
      //  responeMessage('get', apiEnd, res);
      return res;
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      log("get" + apiEnd + e.toString());
    }
  }

  Future<dynamic> postWithFormData(
      {required String apiEnd, Map<String, dynamic>? data}) async {
    try {
      final res = await _dio.post(apiEnd, data: FormData.fromMap(data ?? {}));
      //print("mmmm" + data.toString());
      // responeMessage('post', apiEnd, res);
      // print("mmmm"+res.toString());
      return res;
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      log("post" + apiEnd + e.toString());
    }
  }

  Future<dynamic> deleteWithFormData(
      {required String apiEnd, Map<String, dynamic>? data}) async {
    try {
      final res = await _dio.delete(apiEnd, data: data);
      //print("mmmm" + data.toString());
      //  responeMessage('Delete', apiEnd, res);
      // print("mmmm"+res.toString());
      return res;
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      log("Delete" + apiEnd + e.toString());
    }
  }
}
