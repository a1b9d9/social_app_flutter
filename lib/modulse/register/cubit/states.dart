abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}


class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorState(this.error);
}class SocialCreateRegisterSuccessState extends SocialRegisterStates {}

class SocialCreateRegisterErrorState extends SocialRegisterStates {
  final String error;

  SocialCreateRegisterErrorState(this.error);
}

class ChangeVisiblePasswordRegister extends SocialRegisterStates {}
