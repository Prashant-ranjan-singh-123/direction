import 'package:dio/dio.dart';
import 'package:direction/network/client.dart';

class EndPoints{

  EndPoints._();

  static EndPoints instanse(){
    return EndPoints._();
  }

  Future<Response> direction() async {
    try{
      Response response = await dioClient.dio().get('/direction');
      return response;
    }on DioException catch (e){
      return e.response!;
    }
  }
}