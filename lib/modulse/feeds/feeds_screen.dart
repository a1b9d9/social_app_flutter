import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/models/social_get_post_models.dart';
import 'package:social_app/shared/style/icon-broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = SocialHomeCubit.get(context);
    return BlocConsumer<SocialHomeCubit,SocialHomeStates>(
      listener: (context,state){
        if(state is SocialHomeGetPostErrorState) {
          print(state.error);
        }
      },
      builder:  (context,state){
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                  margin: const EdgeInsets.all(5.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 15,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                            bloc.infoUser.coverImage),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Text("Welcome",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.white)),
                    ],
                  )),//cover image for owner account
              ListView.separated(
                  shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics() ,
                  itemBuilder: (context, index) => buildPost(context,bloc.post[index],bloc.infoUser.profileImage,
                          (){//to add like and get number like
                    bloc.post[index].isLiked=!(bloc.post[index].isLiked);
                   // bloc.refreshPage();
                    bloc.addAndDeleteLikeAndShowNumberOfLike(bloc.post[index].isLiked, bloc.post[index].postId)
                            .then((value) {bloc.post[index].numLike=value;});
                    bloc.refreshPage();

                  }),
                  separatorBuilder:(context,index)=> const SizedBox(height: 5),
                  itemCount: bloc.post.length)
            ],
          ),
        );
      },
    );
  }



  Widget buildPost(context, SocialGetPost post, String profileImage,GestureTapCallback buttonLike )=>Card(
      margin: const EdgeInsets.all(5.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundImage: NetworkImage(
                    post.profileImage,
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
                              post.name,
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
                          post.date,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(height: 1.3),
                        ),
                      ]),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
              ],
            ),//owner post
            Padding(
              padding: const EdgeInsets.only(bottom: 15,top:8),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Text(
              post.text,
              style: Theme.of(context).textTheme.subtitle1,
            ),//post text
            Wrap(
                spacing: 10,
                children:[
                  Container(height: 30,child: InkWell(onTap: (){},child: Text("#hiiiii",style: TextStyle(color: Colors.blue,),))),
                  Container(height: 30,child: InkWell(onTap: (){},child: Text("#Welcome back",style: TextStyle(color: Colors.blue,),))),
                ]
            ), //tags
            if(post.postImage!="")
            Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          post.postImage,
                        )))),//post image
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      InkWell( onTap: (){},
                          child: post.isLiked
                          ? const Icon(EvaIcons.heart,size: 18,color: Colors.red,)
                          :const Icon(IconBroken.Heart,size: 18,color: Colors.red,)

                      ),
                      const SizedBox(width: 5,),
                      if(post.numLike!=0)
                      InkWell( onTap: (){},child: Text(
                        "${post.numLike}",style: TextStyle(color: Colors.grey[500]),)),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: (){},
                    child: Row(
                      children: [
                        Icon(IconBroken.Chat,size: 18,color: Colors.amber,),
                        SizedBox(width: 5,),
                        Text("1200 comments",style: TextStyle(color: Colors.grey[500]),),
                      ],
                    ),
                  ),
                ],
              ),
            ),//info replay post like & comment
            Padding(
              padding: const EdgeInsets.only(bottom:  8,top: 2.5),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: SizedBox(
                      height: 40,
                      child: Row(children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                           profileImage,
                          ),
                        ),//your account profile image
                        const SizedBox(width: 15,),
                        Text("Write a comment ...",style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 13),),

                      ]),
                    ),
                  ),
                ),
                InkWell(
                  onTap: buttonLike,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10),
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          post.isLiked
                              ? const Icon(EvaIcons.heart,size: 18,color: Colors.red,)
                              :const Icon(IconBroken.Heart,size: 18,color: Colors.red,),
                          const SizedBox(width: 5,),
                          Text("Like",style: TextStyle(color: Colors.grey[500]),),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),//owner account
          ],
        ),
      ));
}
