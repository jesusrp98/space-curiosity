import 'dart:async';
import 'dart:convert';
import 'dart:io';

  Future<String> getData(String api, String headers) async {
    var requestURL = api;
    requestURL = requestURL + headers;
    print("Request URL: " + requestURL);

    var url = requestURL;
    var httpClient = new HttpClient();
    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
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