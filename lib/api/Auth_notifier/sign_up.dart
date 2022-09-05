import 'dart:convert';
import 'dart:developer';

import 'package:dating_app/api/base_notifier.dart';
import 'package:dating_app/api/config/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../../screens/home_screen.dart';
import '../config/helper.dart';

class Auth_provider extends BaseNotifier {
  Future sign_up(String uname, String pass, String email) async {
    username = "Admin";
    password = "Login123456";
    Response res = await dioClient.postWithFormData(apiEnd: api_sign_up, data: {
      "username": "$uname",
      "password": "$pass",
      "email": "$email",
    });
    // if (res.statusCode == 200) {
    log("message" + res.toString());
    // }
  }

  Future sign_in(String uname, String pass,BuildContext context) async {
    username = uname;
    password = pass;
    // String basicAuth =
    //     'Basic ' + base64.encode(utf8.encode('$username:$password'));
    // print(basicAuth);
    // Map<String, String> headers = new Map();
    // headers["Authorization"] = basicAuth;
    Response res = await dioClient.getRequest(
      apiEnd: api_sign_in,
    );
    if (res.statusCode == 200) {
        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
      return showToast("Login Success");
      
    }
    if (res.statusCode == 400) {
      return showToast("Login Fail");
    }
    // var res = await http.get(
    //     Uri.parse('https://dev.cbcmsurfndate.net/wp-json/wp/v2/users/me'),
    //     headers: <String, String>{'authorization': basicAuth});
    // var res =
    //     await http.get("https://dev.cbcmsurfndate.net/wp-json/wp/v2/users/me", headers: headers);

    // if (res.statusCode == 200) {
    log("message" + res.data.toString());
    // }
  }
}
