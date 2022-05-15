import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/reuseble_components.dart';
import 'package:social_app/shared/style/icon-broken.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/style/colors.dart';

class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = SocialHomeCubit.get(context);
    var postController = TextEditingController();
    return BlocConsumer<SocialHomeCubit, SocialHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppbar(context: context, title: "Add Post", action: [
            TextButton(onPressed: () {
              bloc.isLoading=true;
              DateTime now = DateTime.now();
              //حل مشكلة انو يكون text null عن طريق الkey
              bloc.uploadPost(text: postController.text,date: now.toString(),isSelectPostImage: bloc.isSelectPostImage);
              bloc.closeProfileImage();
              Future.delayed(
                  const Duration(
                    milliseconds:300,
                  ), () {
                bloc.isLoading = false;
              });
            }, child: const Text("Post"))
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                              if(bloc.isLoading)
                              const LinearProgressIndicator(),
                              Row(
                              children:  [
                                CircleAvatar(
                                  radius: 23,
                                  backgroundImage: NetworkImage(
                                   bloc.infoUser.profileImage,
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Text(
                                  bloc.infoUser.name,
                                  style: const TextStyle(height: 1.3),
                                ),
                              ],
                            ),
                              const SizedBox(height: 8),
                              Expanded(
                              child: TextFormField(
                                controller: postController,
                                decoration: const InputDecoration(
                                    hintText: "What is in your mind.....",
                                    border: InputBorder.none),
                              ),
                            ),
                              if(bloc.isSelectPostImage==true)
                              Expanded(
                                child: Stack(
                                    alignment: AlignmentDirectional.topEnd,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight:
                                              Radius.circular(5)),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:  FileImage(bloc.postImage),
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                          backgroundColor:
                                          defaultColorBackGround,
                                          radius: 18,
                                          child: IconButton(
                                              onPressed: () {
                                                bloc.closeProfileImage();                                              },
                                              icon: const Icon(
                                                Icons.close,
                                                size: 16,
                                              ))),
                                    ]),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                      bloc.getPostImage();
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(IconBroken.Image),
                                          Text("add photo"),
                                        ],
                                      ))),
                              Expanded(
                                  child: TextButton(onPressed: () {}, child: const Text("#tags"))),
                            ]),
            ]),
          ),
        );
      },
    );
  }
}
