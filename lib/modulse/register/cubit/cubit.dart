import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/models/social_info_user_models.dart';
import '../../register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreating(email: email, uId: value.user!.uid, name: name, phone: phone);
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  userCreating({
    required String email,
    required String uId,
    required String name,
    required String phone,
  }) {
    SocialInfoUser model =
        SocialInfoUser(name: name, email: email, phone: phone, uId: uId,profileImage: "",coverImage: "",bio: "");
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(SocialCreateRegisterSuccessState());
    })
        .catchError((error){
      emit(SocialCreateRegisterErrorState(error.toString()));

    });
  }

  bool secure = false;

  void changeIcon() {
    if (secure) {
      secure = false;
      emit(ChangeVisiblePasswordRegister());
    } else {
      secure = true;
      emit(ChangeVisiblePasswordRegister());
    }
  }
}
