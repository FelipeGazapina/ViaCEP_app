import 'package:dio/dio.dart';
import 'package:via_cep_app/connections/viacep_interceptor.dart';

class ViaCEPConnection {
  final Dio _dio = Dio();

  Dio get dio => _dio;

  ViaCEPConnection() {
    _dio.options.baseUrl = "http://viacep.com.br/ws/";
    _dio.interceptors.add(ViaCEPInterceptor());
  }
}
