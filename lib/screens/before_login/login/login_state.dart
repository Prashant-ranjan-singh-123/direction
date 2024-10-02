class LoginState{}

class InitialState extends LoginState{
  bool isInvalidMobileNumber;
  InitialState({required this.isInvalidMobileNumber});
}

class OtpState extends LoginState{}

class WrongOtpState extends LoginState{}