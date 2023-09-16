abstract class SignUpstate {}

class AppInitState extends SignUpstate {}

class ChangeVisState extends SignUpstate {}

class SocialRegisterLoadingState extends SignUpstate {}

class SocialRegisterSuccState extends SignUpstate {
  String Id;
  SocialRegisterSuccState(this.Id);
}

class SocialRegisterErrorState extends SignUpstate {
  String Error;
  SocialRegisterErrorState(this.Error);
}

class SocialCreateUserSuccState extends SignUpstate {}
class SocialCreateUserErrorState extends SignUpstate {
  String Error;
  SocialCreateUserErrorState(this.Error);
}

class SocialIduCheckState extends SignUpstate {}
class SocialIdusededState extends SignUpstate {}