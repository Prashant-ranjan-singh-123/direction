class LoginCheckState{}

class LoadingState extends LoginCheckState{}

class TokenFoundState extends LoginCheckState{}

class TokenNotFoundState extends LoginCheckState{}

class ErrorState extends LoginCheckState{
  String error;
  ErrorState({required this.error});
}