import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserData {
  Map<String, dynamic> data = {
    "user": [
      {
        "uid": "123123",
        "userName": "Bombay Bramble",
        "bottleNumber": "5",
        "LikeNumber": "25",
      },
    ]
  };

  Future<Map<String, String>> loadUserData() async {
    //API통신  location값을 보내주면서
    await Future.delayed(Duration(milliseconds: 500));
    //throw Exception();
    return data["user"];
  }
}

