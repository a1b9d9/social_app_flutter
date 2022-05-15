import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/style/colors.dart';
import 'package:social_app/shared/style/icon-broken.dart';

import '../modulse/add_post/add_post_screen.dart';
import '../shared/components/reuseble_components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialHome extends StatelessWidget {
  const SocialHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = SocialHomeCubit.get(context);
    bloc.getDataUser();
    return BlocConsumer<SocialHomeCubit, SocialHomeStates>(
        listener: (context, state) {
      if (bloc.isPostBottom) {
        bloc.isPostBottom=false;
        navi(context, const AddPost());
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            bloc.currentIndex > 2
                ? bloc.title[bloc.currentIndex - 1]
                : bloc.title[bloc.currentIndex],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  bloc.getPost();
                  bloc.getUsers();
                //  bloc.refreshPage();
                },
                icon: const Icon(
                  IconBroken.Notification,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconBroken.Search,
                )),
          ],
        ),
        body: Column(
          children: [
            if (!bloc.infoUser.isEmailVerified)
              Container(
                color: Colors.amber.withOpacity(0.6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(children: [
                    const Icon(Icons.error),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Pleas Verify Your Email"),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                        },
                        child: const Text("Send"))
                  ]),
                ),
              ),
            Expanded(child:
            bloc.currentIndex > 2
                ? bloc.screen[bloc.currentIndex - 1]
                : bloc.screen[bloc.currentIndex],),
//                const Center(child: CircularProgressIndicator()),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: defaultColor,
          currentIndex: bloc.currentIndex,
          onTap: (index) {
            bloc.changeIndex(index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper_Upload), label: "Add Post"),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Location), label: "Users"),
            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.Setting,
              ),
              label: "Setting",
            ),
          ],
        ),
      );
    });
  }
}
