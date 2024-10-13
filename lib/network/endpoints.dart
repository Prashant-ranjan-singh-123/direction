import 'package:dio/dio.dart';
import 'package:direction/network/client.dart';

class EndPoints{

  EndPoints._();

  static EndPoints instanse(){
    return EndPoints._();
  }

  Future<Response> direction() async {
    try{
      print('error 1');
      Response response = await dioClient.dio().get('/direction');
      print('error 2');
      return response;
    }on DioException catch (e){
      print('error');
      return e.response!;
    }
  }
}