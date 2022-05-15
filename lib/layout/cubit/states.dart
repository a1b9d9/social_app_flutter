abstract class SocialHomeStates {}

class SocialHomeInitialState extends SocialHomeStates {}

class SocialHomeGetUserLoadingState extends SocialHomeStates {}

class SocialHomeGetUserSuccessState extends SocialHomeStates {}

class SocialHomeGetUserErrorState extends SocialHomeStates {
  final String error;

  SocialHomeGetUserErrorState(this.error);
}



class ChangeNivBarState extends SocialHomeStates {}





class SocialHomeEditProfileImageSuccessState extends SocialHomeStates {}

class SocialHomeEditProfileImageErrorState extends SocialHomeStates {
  final String error;

  SocialHomeEditProfileImageErrorState(this.error);
}


class SocialHomeUploadProfileImageSuccessState extends SocialHomeStates {}

class SocialHomeUploadProfileImageErrorState extends SocialHomeStates {
  final String error;

  SocialHomeUploadProfileImageErrorState(this.error);
}






class SocialHomeEditCoverImageSuccessState extends SocialHomeStates {}

class SocialHomeEditCoverImageErrorState extends SocialHomeStates {
  final String error;

  SocialHomeEditCoverImageErrorState(this.error);
}



class SocialHomeUploadCoverImageSuccessState extends SocialHomeStates {}

class SocialHomeUploadCoverImageErrorState extends SocialHomeStates {
  final String error;

  SocialHomeUploadCoverImageErrorState(this.error);
}


class SocialHomeLoadingUploadInfoUserState extends SocialHomeStates {}
class SocialHomeUploadInfoUserSuccessState extends SocialHomeStates {}
class SocialHomeUploadInfoUserErrorState extends SocialHomeStates {
  final String error;

  SocialHomeUploadInfoUserErrorState(this.error);
}







class SocialHomeEditPostImageSuccessState extends SocialHomeStates {}

class SocialHomeEditPostImageErrorState extends SocialHomeStates {
  final String error;

  SocialHomeEditPostImageErrorState(this.error);
}






class SocialHomeLoadingUploadPostState extends SocialHomeStates {}
class SocialHomeUploadPostSuccessState extends SocialHomeStates {}
class SocialHomeUploadPostErrorState extends SocialHomeStates {
  final String error;

  SocialHomeUploadPostErrorState(this.error);
}



class SocialHomeUnSelectPostImageState extends SocialHomeStates {}







class SocialHomeGetPostLoadingState extends SocialHomeStates {}
class SocialHomeGetPostSuccessState extends SocialHomeStates {}
class SocialHomeGetPostErrorState extends SocialHomeStates {
  final String error;

  SocialHomeGetPostErrorState(this.error);
}




class SocialHomeLikePostLoadingState extends SocialHomeStates {}
class SocialHomeLikePostSuccessState extends SocialHomeStates {}
class SocialHomeLikePostErrorState extends SocialHomeStates {
  final String error;

  SocialHomeLikePostErrorState(this.error);
}



class SocialHomeReFreshState extends SocialHomeStates {}





class SocialHomeNumberLikePostSuccessState extends SocialHomeStates {}
class SocialHomeNumberLikePostErrorState extends SocialHomeStates {
  final String error;

  SocialHomeNumberLikePostErrorState(this.error);
}



class SocialHomeSendMessageSuccessState extends SocialHomeStates {}
class SocialHomeSendMessageErrorState extends SocialHomeStates {
  final String error;

  SocialHomeSendMessageErrorState(this.error);
}



class SocialHomeReceiveMessageSuccessState extends SocialHomeStates {}
