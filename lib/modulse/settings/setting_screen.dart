import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modulse/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/reuseble_components.dart';
import 'package:social_app/shared/style/icon-broken.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/network/local/shared_preferences.dart';
import '../../shared/style/colors.dart';
import '../log_in/log_in_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = SocialHomeCubit.get(context);

    return BlocConsumer<SocialHomeCubit, SocialHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: 160,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  bloc.infoUser.coverImage,
                                ),
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: defaultColorBackGround,
                          radius: 62,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              bloc.infoUser.profileImage,
                            ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                    bloc.infoUser.name,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 18,
                      ),
                ),
                Text(bloc.infoUser.bio,
                    style: Theme.of(context).textTheme.caption),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                "100",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text("Post",
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                "100",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text("Post",
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                "100",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text("Post",
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text(
                                "100",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text("Post",
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {},
                          child: const Text(
                            "Edit Profile",
                          )),),
                    const SizedBox(width: 8,),
                    OutlinedButton(
                        onPressed: () {
                          navi(context, const EditProfile());
                        },
                        child: const Icon(IconBroken.Edit)),
                  ],
                ),

                // MaterialButton(onPressed: (){
                //   CacheHelper.clearData(key: "uid");
                //   navi(context, const Login());
                // })
              ],
            ),
          );
        });
  }
}
