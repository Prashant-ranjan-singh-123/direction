import 'package:dio/dio.dart';
import 'package:direction/network/client.dart';
import 'package:direction/network/endpoints.dart';
import 'package:direction/services/prashant_app_open_permission/prashant_app_open__permission_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrashantAppOpenPermissionCubit extends Cubit<PrashantAppOpenPermissionState>{
  PrashantAppOpenPermissionCubit() : super(const PrashantAppOpenPermissionState());

  Future<void> prashantAuth() async {
    emit(
        state.copyWith(
          loadingState: APILoadingState.loading,
          canLoad: 0,
          visibility: false
        )
    );

    try {
      Response data = await EndPoints.instanse().direction();
      if (data.statusCode != 200) {
        emit(
            state.copyWith(
              loadingState: APILoadingState.success,
              canLoad: 1,
            )
        );
      } else {
        if (data.data['success']) {
          emit(
              state.copyWith(
                loadingState: APILoadingState.success,
                canLoad: 1,
                visibility: true,
              )
          );
        } else {
          emit(
              state.copyWith(
                loadingState: APILoadingState.failed,
                canLoad: 2,
              )
          );
        }
      }
    } catch (e){
      emit(
          state.copyWith(
            loadingState: APILoadingState.failed,
            canLoad: 1,
          )
      );
    }
  }

}