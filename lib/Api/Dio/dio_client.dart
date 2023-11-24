import 'package:Leaf_Flow/Api/api_value.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClinet {
  Dio? dio;
  static DioClinet? _instance;
  Map<String, dynamic> defaultHEADERS = {"Content-Type": "application/json"};

  DioClinet._internal() {
    dio = Dio();
    dio?.options.baseUrl = ApiValue.BASE_URL;
    dio?.options.headers = defaultHEADERS;
    dio?.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
  }

  static DioClinet get instance {
    _instance ??= DioClinet._internal();
    return _instance!;
  }
}
