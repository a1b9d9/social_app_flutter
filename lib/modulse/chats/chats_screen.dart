import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/reuseble_components.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/models/social_get_users.dart';
import '../chats_masseges/chats_masseges_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var bloc = SocialHomeCubit.get(context);

    return BlocConsumer<SocialHomeCubit,SocialHomeStates>(
        listener: (context,state){},
        builder: (context,state){
          return  bloc.users.isNotEmpty
              ?ListView.separated(
              itemBuilder: (context, index) =>buildUsers(context: context, user:bloc.users[index]),
              separatorBuilder: (context,index)=>Padding(
                padding: const EdgeInsets.only(bottom: 15,top:8),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              itemCount: bloc.users.length)
              :const Center(child: CircularProgressIndicator());
        });

  }
}




Widget buildUsers({required context, required SocialGetUser user}){
  return InkWell(
    onTap: (){
      navi(context,  MessagesScreen(name: user.name,imageProfile: user.profileImage,uid: user.uId,));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal:8 ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              user.profileImage,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(height: 1.3),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                        size: 15,
                      )
                    ],
                  ),
                  Text(
                    user.bio,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(height: 1.3),
                  ),
                ]),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ],
      ),
    ),
  ) ;
}
