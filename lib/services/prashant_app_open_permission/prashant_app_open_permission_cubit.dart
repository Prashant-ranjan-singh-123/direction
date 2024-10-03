import 'package:dio/dio.dart';
import 'package:direction/network/client.dart';
import 'package:direction/network/endpoints.dart';
import 'package:direction/services/prashant_app_open_permission/prashant_app_open__permission_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrashantAppOpenPermissionCubit extends Cubit<PrashantAppOpenPermissionState>{
  PrashantAppOpenPermissionCubit() : super(InitialState(loading: true, canLoad: 0));

  Future<void> prashantAuth() async {
    emit(InitialState(loading: true, canLoad: 0));

    try {
      Response data = await EndPoints.instanse().direction();
      if (data.statusCode != 200) {
        emit(InitialState(loading: false, canLoad: 1));
      } else {
        if (data.data['success']) {
          emit(InitialState(loading: false, canLoad: 1));
        } else {
          emit(InitialState(loading: false, canLoad: 2));
        }
      }
    } catch (e){
      emit(InitialState(loading: false, canLoad: 1));
    }
  }
}