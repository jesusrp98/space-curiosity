library globals;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

//Variables
bool isLoggedIn = false;
String token = "";
String domain = "";
String apiURL = "https://reqres.in/api/users/2";
String error = "";

String title = '';
String description = "";
String imageurl = '';
String hdimageurl = '';
String datecreated = '';

String id = "0";
String firstname = "Test";
String lastname = "Test";
String avatar =
    "https://s3.amazonaws.com/uifaces/faces/twitter/josephstein/128.jpg";

class Utility {
  static void showAlertPopup(
      BuildContext context, String title, String detail) async {
    void showDemoDialog<T>({BuildContext context, Widget child}) {
      showDialog<T>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => child,
      );
    }

    return showDemoDialog<Null>(
        context: context,
        child: NativeDialog(
          title: title,
          content: detail,
          actions: <NativeDialogAction>[
            NativeDialogAction(
                text: 'OK',
                isDestructive: false,
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ));
  }
  static Future<String> getData(String api, String headers) async {
    var requestURL = api;
    requestURL = requestURL + headers;
    print("Request URL: " + requestURL);

    var url = requestURL;
    var httpClient = new HttpClient();
    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        try {
          var json = await response.transform(utf8.decoder).join();
          result = json;
        } catch (exception) {
          result = 'Error Getting Data';
        }
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address $exception';
    }
    print("Result: " + result);
    return result;
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
