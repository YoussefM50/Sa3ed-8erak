import 'package:dio/dio.dart';

class ApiService {
  final _Base_Url = "https://sa3ed.pythonanywhere.com/recommendations/";
  final Dio _dio;

  ApiService(this._dio);
  Future<Map<String, dynamic>> get({required String end_point}) async {
    Map<String, dynamic> Empty_Map = {};
    var response = await _dio.get('$_Base_Url$end_point');
    if (response.data is String) {
      return Empty_Map;
    } else {
      return response.data;
    }
  }
}
