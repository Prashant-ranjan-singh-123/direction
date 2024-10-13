import 'package:equatable/equatable.dart';

class LoginState extends Equatable{
  bool loading;
  LoginState(this.loading);

  LoginState copyWith({
    bool loading=true
}){
    return LoginState(
      loading?? this.loading
    );
  }

  @override
  List<Object?> get props => [loading];
}