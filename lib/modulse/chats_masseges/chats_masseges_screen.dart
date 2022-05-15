import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/style/icon-broken.dart';

import '../../layout/cubit/cubit.dart';

class MessagesScreen extends StatelessWidget {
  final String name;
  final String imageProfile;
  final String uid;

  const MessagesScreen({Key? key, required this.name,required this.imageProfile,required this.uid,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var bloc = SocialHomeCubit.get(context);
    var textMessages =TextEditingController();
      return Builder(
        builder: (context){
          bloc.getMessage(uId: uid);
          return BlocConsumer<SocialHomeCubit,SocialHomeStates>(
              listener:(context, state) {},
              builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title:Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
                    child: Row(children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:NetworkImage(imageProfile) ,

                      ),
                      const SizedBox(width: 10,),
                      Text(name,style: const TextStyle(fontWeight: FontWeight.w700)),
                    ]),
                  ) ,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20),
                  child: Column(children: [

                    Expanded(
                      child: ListView.separated(
                 //       physics: ,
                          itemBuilder: (context, index) {
                            if(bloc.messages[index].senderId==bloc.infoUser.uId) {
                              return myMessages(messages: bloc.messages[index].text);
                            }
                            return yourMessages(messages: bloc.messages[index].text);
                          },
                          separatorBuilder: (context, index)=>const SizedBox(height: 10),
                          itemCount: bloc.messages.length
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      padding: const EdgeInsetsDirectional.only(start: 8),
                      decoration: BoxDecoration(
                          border:Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)

                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                                controller: textMessages,
                                decoration: const InputDecoration(
                                    border: InputBorder.none ,
                                    hintText: "Write your messages her ...."),


                              )),
                          MaterialButton(
                            color: Colors.indigo,
                            onPressed: (){
                              if(textMessages.text !="") {
                                bloc.sendMessage(
                                  receiveId:uid,
                                  text: textMessages.text,
                                  dateTime: DateTime.now().toString(),
                                );
                              }
                              textMessages=TextEditingController();
                              bloc.refreshPage();
                            },
                            minWidth: 5,
                            height: 50,
                            child:const Icon(IconBroken.Send,color:Colors.white),)

                        ],
                      ),
                    ),
                  ]),
                ),
              );
            });},
      );
  }



  Align myMessages({required String messages}){
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Container(
        padding:  const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
        decoration: BoxDecoration(
            color: Colors.indigo[200],
            borderRadius: const BorderRadiusDirectional.only(
                bottomEnd:Radius.circular(0),
                bottomStart: Radius.circular(7),
                topEnd: Radius.circular(7),
                topStart:Radius.circular(7) )),
        child: Text(messages),
      ),
    );
  }
  Align yourMessages({required String messages}){
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        padding:  const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
                bottomEnd:Radius.circular(7),
                bottomStart: Radius.circular(0),
                topEnd: Radius.circular(7),
                topStart:Radius.circular(7) )),
        child: Text(messages,style: TextStyle(color: Colors.white), ),
      ),
    );
  }
}