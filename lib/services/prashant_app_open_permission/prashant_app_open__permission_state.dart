import 'package:equatable/equatable.dart';

enum APILoadingState {
  none,
  loading,
  success,
  failed,
}



class PrashantAppOpenPermissionState extends Equatable {

  const PrashantAppOpenPermissionState({
    this.loadingState,
    this.canLoad = 0,
    this.visibility = false,
  });


  final APILoadingState? loadingState;
  final int canLoad; // 0 -> do nothing, 1 -> open app, 2 -> not open app
  final visibility;

  PrashantAppOpenPermissionState copyWith({
    APILoadingState? loadingState,
    int? canLoad,
    bool visibility=false,

  }) {

    return PrashantAppOpenPermissionState(
      loadingState: loadingState ?? this.loadingState,
      canLoad: canLoad ?? this.canLoad,
      visibility: visibility ?? this.visibility,
    );

  }


  @override
  List<Object?> get props => [
    loadingState,
    canLoad,
    visibility
  ];

}
