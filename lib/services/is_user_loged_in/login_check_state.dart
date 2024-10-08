import 'package:equatable/equatable.dart';

class LoginCheckState extends Equatable {
  bool loading;
  String? error;
  bool? isTokenPresent;

  LoginCheckState(
      {this.loading = true, this.error = null, this.isTokenPresent = null});

  LoginCheckState copyWith({
    bool? loading = true,
    String? error = null,
    bool? isTokenPresent = null,
  }) {
    return LoginCheckState(
        loading: loading ?? this.loading,
        error: error ?? this.error,
        isTokenPresent: isTokenPresent ?? this.isTokenPresent);
  }

  @override
  List<Object?> get props => [loading, error, isTokenPresent];
}
