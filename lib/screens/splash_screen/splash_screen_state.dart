import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class SplashScreenState extends Equatable {
  bool loading;
  SplashScreenState({this.loading = true});

  SplashScreenState copyWith({
    bool loading = true,
  }) {
    return SplashScreenState(loading: this.loading);
  }

  @override
  List<Object?> get props => [loading];
}
