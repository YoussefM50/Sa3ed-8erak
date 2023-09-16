abstract class LogInstate{}

class AppInitState extends LogInstate{}

class ChangeVisState extends LogInstate{}
class SocialLoginLoadingState extends LogInstate{}
class SocialRegisterSuccState extends LogInstate{
  String Id;
  SocialRegisterSuccState(this.Id);
}
class SocialRegisterErrorState extends LogInstate{
    String error;
  SocialRegisterErrorState(this.error);
}
class SocialResetPassSuccState extends LogInstate{

  SocialResetPassSuccState();
}
class SocialResetPassErrorState extends LogInstate{
    String error;
  SocialResetPassErrorState(this.error);
}


