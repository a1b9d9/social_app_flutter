import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modulse/log_in/cubit/states.dart';

import '../../../shared/network/local/shared_preferences.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  //late LoginInfo info;

  void userLogin({required String email, required String password}) {
    emit(SocialLoginLoadingState());
    {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
          //  print(value.user!.uid);
        CacheHelper.putData(key: "uid", value: value.user!.uid)
            .then((value) {
          if (value) {
            emit(SocialLoginSuccessState());
          }
        }).catchError((onError) {
         // print(onError);
          emit(SocialLoginErrorState(onError.toString()));
        });
      }).catchError((error) {
        emit(SocialLoginErrorState(error.toString()));
      });
    }
  }

  bool secure = false;

  void changeIcon() {
    if (secure) {
      secure = false;
      emit(ChangeVisiblePassword());
    } else {
      secure = true;
      emit(ChangeVisiblePassword());
    }
  }
}
