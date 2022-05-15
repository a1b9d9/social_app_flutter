import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/reuseble_components.dart';
import 'package:social_app/shared/style/icon-broken.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/style/colors.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = SocialHomeCubit.get(context);
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController(text: bloc.infoUser.name);
    var bioController = TextEditingController(text: bloc.infoUser.bio);
    var phoneController = TextEditingController(text: bloc.infoUser.phone);

    return BlocConsumer<SocialHomeCubit, SocialHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar:
              defaultAppbar(context: context, title: "Edit Profile", action: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 5),
              child: TextButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus
                        ?.unfocus(); //هون لنسكر الكيبورد
                    if (formKey.currentState!.validate()) {
                      bloc.isLoading = true;
                      bloc.uploadInfoUser(
                          nameBeFor: bloc.infoUser.name,
                          nameAfter: nameController.text,
                          bioBeFor: bloc.infoUser.bio,
                          bioAfter: bioController.text,
                          phoneBeFor: bloc.infoUser.phone,
                          phoneAfter:phoneController.text ,

                      );
                    }
                    Future.delayed(
                        const Duration(
                          milliseconds:300,
                        ), () {
                      bloc.isLoading = false;
                    });

                    bloc.getDataUser();
                  },
                  child: const Text("Update")),
            )
          ]),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (bloc.isLoading) const LinearProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Align(
                                  child: Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        Container(
                                          height: 160,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5)),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: !bloc.isLocalCoverImage
                                                  ? NetworkImage(
                                                      bloc.infoUser.coverImage,
                                                    )
                                                  : FileImage(bloc.coverImage)
                                                      as ImageProvider,
                                            ),
                                          ),
                                        ),
                                        CircleAvatar(
                                            backgroundColor:
                                                defaultColorBackGround,
                                            radius: 20,
                                            child: IconButton(
                                                onPressed: () {
                                                  bloc.getCoverImage();
                                                },
                                                icon: const Icon(
                                                  Icons.add_a_photo_outlined,
                                                ))),
                                      ]),
                                  alignment: AlignmentDirectional.topCenter,
                                ),
                                CircleAvatar(
                                  backgroundColor: defaultColorBackGround,
                                  radius: 62,
                                  child: Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        CircleAvatar(
                                            radius: 60,
                                            backgroundImage: !bloc
                                                    .isLocalProfileImage
                                                ? NetworkImage(
                                                    bloc.infoUser.profileImage,
                                                  )
                                                : FileImage(bloc.profileImage)
                                                    as ImageProvider),
                                        CircleAvatar(
                                            backgroundColor:
                                                defaultColorBackGround,
                                            radius: 18,
                                            child: IconButton(
                                                onPressed: () {
                                                  bloc.getProfileImage();
                                                },
                                                icon: const Icon(
                                                  Icons.add_a_photo_outlined,
                                                  size: 18,
                                                ))),
                                      ]),
                                ),
                              ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        formField(
                          controller: nameController,
                          type: TextInputType.text,
                          label: "Name",
                          preIcon: const Icon(Icons.how_to_reg),
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "please enter your Name";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        formField(
                          controller: bioController,
                          type: TextInputType.text,
                          label: "bio",
                          preIcon: const Icon(IconBroken.Info_Circle),
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "please enter your bio";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        formField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: "Phone",
                          preIcon: const Icon(IconBroken.Call),
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "please enter your Phone";
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
