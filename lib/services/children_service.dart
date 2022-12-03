import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proy_taller/constant.dart';
import 'package:proy_taller/models/api_response.dart';
import 'package:proy_taller/models/children.dart';
import 'package:proy_taller/services/user_service.dart';

Future<ApiResponse> getChildren() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(childrenUrl),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['children'].map((p) => Children.fromJson(p)).toList();
        apiResponse.data as List<dynamic>;
      break;
      case 401:
        apiResponse.error = unauthorized;
      break;
      default:
       apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
      apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> getKid(int childId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('$childrenUrl/$childId'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['children'].map((p) => Children.fromJson(p)).toList();
        apiResponse.data as List<dynamic>;
      break;
      case 401:
        apiResponse.error = unauthorized;
      break;
      default:
       apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
      apiResponse.error = serverError;
  }
  return apiResponse;
}