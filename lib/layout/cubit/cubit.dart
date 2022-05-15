import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modulse/chats/chats_screen.dart';
import 'package:social_app/modulse/feeds/feeds_screen.dart';
import 'package:social_app/modulse/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/shared/models/social_user_message.dart';

import '../../../shared/network/local/shared_preferences.dart';
import '../../modulse/settings/setting_screen.dart';
import '../../shared/models/social_add_post_models.dart';
import '../../shared/models/social_get_post_models.dart';
import '../../shared/models/social_get_users.dart';
import '../../shared/models/social_info_user_models.dart';

class SocialHomeCubit extends Cubit<SocialHomeStates> {
  SocialHomeCubit() : super(SocialHomeInitialState());

  static SocialHomeCubit get(context) => BlocProvider.of(context);

  SocialInfoUser infoUser = SocialInfoUser(
      email: "",
      name: "",
      phone: "",
      uId: "",
      isEmailVerified: false,
      profileImage: "",
      bio: "",
      coverImage: "");

  void getDataUser() {
    emit(SocialHomeGetUserLoadingState());

    FirebaseFirestore.instance
        .collection("users")
        .doc(CacheHelper.getData(key: "uid"))
        .get()
        .then((value) {
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(CacheHelper.getData(key: "uid"))
            .update({"isEmailVerified": true});
      }
      //     print(value.data());
      infoUser = SocialInfoUser.fromJson(value.data());
      emit(SocialHomeGetUserSuccessState());
    }).catchError((error) {
      emit(SocialHomeGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screen = [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingScreen()
  ];


  List<String> title = [
    "Home",
    "Chat",
    "User",
    "Setting",
  ];


  bool isPostBottom = false;

  void changeIndex(int index) {
  //  print(infoUser.uId);
    if (index != 2) {
      currentIndex = index;
      emit(ChangeNivBarState());
    } else {
      isPostBottom = true;
      emit(ChangeNivBarState());
    }
  }

  late File profileImage;
  late var picker = ImagePicker();
  bool isLocalProfileImage = false;

  Future getProfileImage() async {
    var pickFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickFile != null) {
      profileImage = File(pickFile.path);
      isLocalProfileImage = true;
      emit(SocialHomeEditProfileImageSuccessState());
    }
    else{
      emit(SocialHomeEditProfileImageErrorState("Field Select"));
    }
  }

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            "users/${CacheHelper.getData(key: "uid")}/profile_image/${Uri.file(profileImage.path).pathSegments.last}")
        .putFile(profileImage)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(CacheHelper.getData(key: "uid"))
            .update({"profile_image": value});
        emit(SocialHomeEditCoverImageSuccessState());
      }).catchError((onError) {
        //print(onError.toString());
        emit(SocialHomeEditCoverImageErrorState(onError.toString()));
      });
    }).catchError((onError) {
      //print(onError.toString());
      emit(SocialHomeEditCoverImageErrorState(onError.toString()));
    });
  }

  bool isLocalCoverImage = false;
  late File coverImage;

  Future getCoverImage() async {
    var pickFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickFile != null) {
      coverImage = File(pickFile.path);
      isLocalCoverImage = true;

      emit(SocialHomeEditCoverImageSuccessState());
    }
    else{
      emit(SocialHomeEditCoverImageErrorState("Field Select"));
    }
  }

  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            "users/${CacheHelper.getData(key: "uid")}/cover_image/${Uri.file(coverImage.path).pathSegments.last}")
        .putFile(coverImage)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(CacheHelper.getData(key: "uid"))
            .update({"cover_image": value})
            .then((value) {
          emit(SocialHomeUploadCoverImageSuccessState());
        }).catchError((onError) {
          emit(SocialHomeUploadCoverImageErrorState(onError.toString()));
        });
      }).catchError((onError) {
        emit(SocialHomeUploadCoverImageErrorState(onError.toString()));
      });
    }).catchError((onError) {
      emit(SocialHomeUploadCoverImageErrorState(onError.toString()));
    });
  }

  void updateInfoUser({required String key, required value}) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(CacheHelper.getData(key: "uid"))
        .update({key: value}).then((value) {
      emit(SocialHomeUploadInfoUserSuccessState());
    }).catchError((onError) {
      emit(SocialHomeUploadInfoUserErrorState(onError.toString()));
    });
  }

  bool isLoading = false;

  void uploadInfoUser({
    required String nameBeFor,
    required String nameAfter,
    required String bioBeFor,
    required String bioAfter,
    required String phoneBeFor,
    required String phoneAfter,
  }) {
    if (isLocalCoverImage) {
      emit(SocialHomeLoadingUploadInfoUserState());
      uploadCoverImage();
    }
    if (isLocalProfileImage) {

      emit(SocialHomeLoadingUploadInfoUserState());
      uploadProfileImage();
    }
    if (nameBeFor != nameAfter) {
      emit(SocialHomeLoadingUploadInfoUserState());
      updateInfoUser(key: "name", value: nameAfter);
    }
    if (bioBeFor != bioAfter ) {
      emit(SocialHomeLoadingUploadInfoUserState());
      updateInfoUser(key: "bio", value: bioAfter);
    }

  }






  late File postImage;
  bool isSelectPostImage=false;

  Future getPostImage() async {
    var pickFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickFile != null) {
      postImage = File(pickFile.path);
      isSelectPostImage=true;
      emit(SocialHomeEditPostImageSuccessState());
    }
    else{
      emit(SocialHomeEditPostImageErrorState("Field Select"));
    }
  }



  void closeProfileImage(){
    isSelectPostImage=false;
    emit(SocialHomeUnSelectPostImageState());
  }




  late SocialAddPost createPost;

  void uploadPost(
  {
    required String text,
    required String date,
    required bool isSelectPostImage,
  }) {
emit(SocialHomeLoadingUploadPostState());
if (!isSelectPostImage){
  createPost=SocialAddPost(text: text,date: date,postImage:"", uid: CacheHelper.getData(key: "uid"));
  FirebaseFirestore.instance
      .collection("post")
      .add(createPost.toMap())
      .then((value) {
        emit(SocialHomeUploadPostSuccessState());
  })
      .catchError((onError){
    emit(SocialHomeUploadPostErrorState(onError.toString()));
  });
}
else{
  firebase_storage.FirebaseStorage.instance
      .ref()
      .child(
      "users/${CacheHelper.getData(key: "uid")}/post/${Uri.file(postImage.path).pathSegments.last}")
      .putFile(postImage)
      .then((p0){
    p0.ref.getDownloadURL().then((value) {
    createPost=SocialAddPost(text: text,date: date,postImage:value, uid: CacheHelper.getData(key: "uid"));
      FirebaseFirestore.instance
          .collection("post")
          .add(createPost.toMap())
          .then((value) {
        emit(SocialHomeUploadPostSuccessState());
      })
          .catchError((onError) {
        emit(SocialHomeUploadPostErrorState(onError.toString()));
      });
    })
        .catchError((onError){
      emit(SocialHomeUploadPostErrorState(onError.toString()));

    });

  })
      .catchError((onError){
    emit(SocialHomeUploadPostErrorState(onError.toString()));

  });
}

  }



List<SocialGetPost>post=[];
  void getPost()
  {
  emit(SocialHomeGetPostLoadingState());
  FirebaseFirestore.instance        // to get all post of you and your friends
        .collection("post")
        .where(CacheHelper.getData(key: "uid")) //to put your id and id your friends to get post
        .get()
        .then((value){
          value.docs.forEach((element0) {
             FirebaseFirestore.instance //to get info of owner post like name and  image profile
                 .collection("users")
                 .doc(element0.data()["uid"])
                 .get()
                  //info user
                 .then((infoU){
               post.clear();

               //to check if owner account liked a post or not
                     FirebaseFirestore.instance
                         .collection("post")
                     //id post
                         .doc(element0.id)
                         .collection("like")
                     //your id to check
                         .doc(CacheHelper.getData(key: "uid"))
                         .get()
                         .then((value) {
                       //to get number of like
                       numberOfLike(element0.id)
                           .then((numLike) {
                         if (value.data()!=null){

                           //to put post in list to show to user
                           post.add(SocialGetPost.fromJson(
                               element0.data(),{"profile_image": infoU.data()!["profile_image"],"name":infoU.data()!["name"],
                             "is_liked":true,"post_id":element0.id,"num_like":numLike}),);}

                         else{
                           //to put post in list to show to user
                           post.add(SocialGetPost.fromJson(
                               element0.data(),{"profile_image": infoU.data()!["profile_image"],"name":infoU.data()!["name"],
                             "is_liked":false,"post_id":element0.id,"num_like":numLike}),);}
                       })
                           .catchError((onError){
                         emit(SocialHomeGetPostErrorState(onError.toString()));

                       });


                         }).catchError((onError){
                       emit(SocialHomeGetPostErrorState(onError.toString()));
                     });

             })
                 .catchError((onError){
               emit(SocialHomeGetPostErrorState(onError.toString()));

             });
          });
          emit(SocialHomeGetPostSuccessState());
    })
        .catchError((onError){
      emit(SocialHomeGetPostErrorState(onError.toString()));
    });
  }

  Future<bool> addRemoveLike({required bool isLiked,required String id}){
    emit(SocialHomeLikePostLoadingState());
    isLiked=!isLiked;
    if(isLiked){

      //to check if owner account liked a post or not
      return FirebaseFirestore.instance
          .collection("post")
      //id post
          .doc(id)
          .collection("like")
          .doc(CacheHelper.getData(key: "uid")) //your id to check
          .delete()
          .then((value) {
         emit(SocialHomeLikePostSuccessState());
         return !isLiked;
      })
          .catchError((onError){
        emit(SocialHomeLikePostErrorState(onError.toString()));
        return isLiked;

      });
    }

    else{
      //to check if owner account liked a post or not
      return  FirebaseFirestore.instance
          .collection("post")
          .doc(id)    //id post
          .collection("like")
      //your id to check
          .doc(CacheHelper.getData(key: "uid"))
          .set({"like_type":"Like"})
          .then((value) {
             emit(SocialHomeLikePostSuccessState());
             return !isLiked;
      })
          .catchError((onError){
        emit(SocialHomeLikePostErrorState(onError.toString()));
        return isLiked;
      });
    }
  }

Future<int>  numberOfLike(String postId) {
  int numLike = 0;
  //to check if owner account liked a post or not
     return FirebaseFirestore.instance
        .collection("post")
        .doc(postId) //id post
        .collection("like")
        .get()
        .then((value) {
      numLike = value.docs.length;
      emit(SocialHomeNumberLikePostSuccessState());
      return numLike;
    })
        .catchError((onError) {
      emit(SocialHomeNumberLikePostErrorState(onError.toString()));
    });

}

//to increase number line of code when add like and refresh
Future<int> addAndDeleteLikeAndShowNumberOfLike(bool isLiked,String postId)async {
  return addRemoveLike(
        isLiked: isLiked,
        id:postId)
        .then((value) {
      return  numberOfLike(postId)
        .then((value) {
          return value;
    });
  });
}

  void refreshPage(){
    emit(SocialHomeReFreshState());
  }







  List<SocialGetUser> users=[];
  void getUsers(){
    users.clear();
    emit(SocialHomeGetUserLoadingState());
    FirebaseFirestore.instance //to check if owner account liked a post or not
        .collection("users")
        .get()
        .then((value){
        value.docs.forEach((element) {
          if(CacheHelper.getData(key:"uid")!=element.data()["uId"]) {
            users.add( SocialGetUser.fromJson(element.data()));
          }
        });
        emit(SocialHomeGetUserSuccessState());
    })
        .catchError((onError){
          emit(SocialHomeGetUserErrorState(onError.toString()));
    });
  }




  void sendMessage({
  required String receiveId,
  required String text,
  required String dateTime,
}){
    MessagesUser infoMessage= MessagesUser(text: text, senderId: infoUser.uId, receiverId: receiveId, dateTime: dateTime);

    //send messages to my own database
FirebaseFirestore.instance
    .collection("users")
    .doc(infoUser.uId)
    .collection("chats")
    .doc(receiveId)
    .collection("messages")
    .add(infoMessage.toMap())
    .then((value) {emit(SocialHomeSendMessageSuccessState());})
    .catchError((onError){emit(SocialHomeSendMessageErrorState(onError.toString()));});


    //send messages to receiver database
    FirebaseFirestore.instance
        .collection("users")
        .doc(receiveId)
        .collection("chats")
        .doc(infoUser.uId)
        .collection("messages")
        .add(infoMessage.toMap())
        .then((value) {emit(SocialHomeSendMessageSuccessState());})
        .catchError((onError){emit(SocialHomeSendMessageErrorState(onError.toString()));});

  }


List<MessagesUser>messages=[];
 void getMessage({required String uId}){
   FirebaseFirestore.instance
       .collection("users")
       .doc(infoUser.uId)
       .collection("chats")
       .doc(uId)
        .collection('messages')
       .orderBy("date_time")
       .snapshots()
       .listen((event) {
     messages=[];
         event.docs.forEach((element) {
           messages.add(MessagesUser.fromJson(element.data()));
         });
         emit(SocialHomeReceiveMessageSuccessState());
   });
    
 }
}
