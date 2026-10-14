import 'package:flutter/foundation.dart';
import 'package:free_to_game/helpers/consts.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<http.Response> get(String endPoint) async {
    var response = await http.get(Uri.parse(baseUrl + endPoint));

    if (kDebugMode) {
      print("---- --- --- --- ");
      print("--- GET URL :$baseUrl$endPoint ---");
      print("--- GET STATUSCODE : ${response.statusCode}");
      print("--- GET RESPONSE : ${response.body}");
      print("---- --- --- --- ");
    }

    return response;
  }

  Future<http.Response> post(String endPoint, Map body) async {
    var response = await http.post(Uri.parse(baseUrl + endPoint), body: body);
    if (kDebugMode) {
      print("---- --- --- --- ");
      print("--- POST URL :$baseUrl$endPoint ---");
      print("--- POST STATUSCODE : ${response.statusCode}");
      print("--- POST RESPONSE : ${response.body}");
      print("---- --- --- --- ");
    }
    return response;
  }

  Future<http.Response> put(String endPoint, Map body) async {
    var response = await http.put(Uri.parse(baseUrl + endPoint), body: body);
    if (kDebugMode) {
      print("---- --- --- --- ");
      print("--- PUT URL :$baseUrl$endPoint ---");
      print("--- PUT STATUSCODE : ${response.statusCode}");
      print("--- PUT RESPONSE : ${response.body}");
      print("---- --- --- --- ");
    }
    return response;
  }

  Future<http.Response> delete(String endPoint, Map body) async {
    var response = await http.delete(Uri.parse(baseUrl + endPoint), body: body);
    if (kDebugMode) {
      print("---- --- --- --- ");
      print("--- DELETE URL :$baseUrl$endPoint ---");
      print("--- DELETE STATUSCODE : ${response.statusCode}");
      print("--- DELETE RESPONSE : ${response.body}");
      print("---- --- --- --- ");
    }
    return response;
  }
}
