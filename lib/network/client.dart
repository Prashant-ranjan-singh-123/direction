import 'package:dio/dio.dart';

class Client{
  // Client._();
  String _baseUrl='https://direction-starting-logic.vercel.app';
  Dio dio(){
    return Dio(BaseOptions(baseUrl: _baseUrl));
  }
}

Client dioClient = Client();