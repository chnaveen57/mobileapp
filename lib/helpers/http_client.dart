import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpClientHelper {
  static Future<http.Response> getData(String url) async {
    return await http.get(url);
  }

  static Future<http.Response> postData<T>(String url, T data) async {
    return await http.post(url,
        body: json.encode(data), headers: {"Content-Type": "application/json"});
  }

  static Future<http.Response> putData<T>(String url, T data) async {
    return await http.put(url,
        body: json.encode(data), headers: {"Content-Type": "application/json"});
  }
}
