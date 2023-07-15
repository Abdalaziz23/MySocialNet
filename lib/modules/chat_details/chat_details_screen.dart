import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  // const ChatDetailsScreen({Key? key}) : super(key: key);
  SocialUserModel? socialUserModel;
  ChatDetailsScreen({
    // super.key,
    this.socialUserModel,
  });
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context)
    {
      SocialCubit.get(context).getMessages(
        receiverId: socialUserModel!.uId!,
      );
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                      '${socialUserModel?.image}',
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '${socialUserModel?.name}',
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context,index)
                      {
                        var message =  SocialCubit.get(context).messages[index];
                        if( SocialCubit.get(context).model?.uId == message.senderId) {
                          return buildMyMessage(message);
                        }
                        return buildMessage(message);
                      },
                      separatorBuilder: (context,index)
                      {
                        return SizedBox(
                          height: 15,
                        );
                      },
                      itemCount: SocialCubit.get(context).messages.length,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey[300],
                          ),
                          child: TextFormField(
                            controller: messageController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Massage',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(25),
                          color: Colors.black12,
                        ),
                        child: MaterialButton(
                          height: 45,
                          minWidth: 1.0,
                          onPressed: () {
                            SocialCubit.get(context).sendMessage(
                              receiverId: socialUserModel!.uId!,
                              dateTime: DateTime.now().toString(),
                              text: messageController.text,
                            );
                          },
                          child: const Icon(
                            IconBroken.Send,
                            size: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          );
        },
      );
    });
  }

  Widget buildMessage(MessageModel? messageModel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            ),
          ),
          child: Text(
            '${messageModel?.text}',
          ),
        ),
      );
  Widget buildMyMessage(MessageModel? messageModel) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(.2),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            ),
          ),
          child: Text(
            '${messageModel?.text}',
          ),
        ),
      );
}

//
// body: Padding(
// padding: const EdgeInsets.all(20.0),
// child: Column(
// children: [
// Expanded(
// child: ListView.separated(
// physics: BouncingScrollPhysics(),
// itemBuilder: (context, index)
// {
// var message = SocialCubit.get(context).messages[index];
//
// if(SocialCubit.get(context).model?.uId == message.senderId)
// return buildMyMessage(message);
//
// return buildMessage(message);
// },
// separatorBuilder: (context, index) => SizedBox(
// height: 15.0,
// ),
// itemCount: SocialCubit.get(context).messages.length,
// ),
// ),
// Container(
// decoration: BoxDecoration(
// border: Border.all(
// color: Colors.grey,
// width: 1.0,
// ),
// borderRadius: BorderRadius.circular(
// 15.0,
// ),
// ),
// clipBehavior: Clip.antiAliasWithSaveLayer,
// child: Row(
// children: [
// Expanded(
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 15.0,
// ),
// child: TextFormField(
// controller: messageController,
// decoration: InputDecoration(
// border: InputBorder.none,
// hintText: 'type your message here ...',
// ),
// ),
// ),
// ),
// Container(
// height: 50.0,
// color: Colors.blue,
// child: MaterialButton(
// onPressed: () {
// SocialCubit.get(context).sendMessage(
// receiverId: socialUserModel!.uId!,
// dateTime: DateTime.now().toString(),
// text: messageController.text,
// );
// },
// minWidth: 1.0,
// child: Icon(
// IconBroken.Send,
// size: 16.0,
// color: Colors.white,
// ),
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// ),
///////////////

// class ChatDetailsScreens extends StatelessWidget {
//   SocialUserModel? userModel;
//
//   ChatDetailsScreens({
//     this.userModel,
//   });
//
//   var messageController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (BuildContext context) {
//         SocialCubit.get(context).getMessages(
//           receiverId: userModel!.uId!,
//         );
//
//         return BlocConsumer<SocialCubit, SocialStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             return Scaffold(
//               appBar: AppBar(
//                 titleSpacing: 0.0,
//                 title: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 20.0,
//                       backgroundImage: NetworkImage(
//                         userModel!.image!,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 15.0,
//                     ),
//                     Text(
//                       userModel!.name!,
//                     ),
//                   ],
//                 ),
//               ),
//               body: ConditionalBuilder(
//                 condition: SocialCubit.get(context).messages.length > 0 ,
//                 builder: (context) => Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: ListView.separated(
//                           physics: BouncingScrollPhysics(),
//                           itemBuilder: (context, index)
//                           {
//                             var message = SocialCubit.get(context).messages[index];
//
//                             if(SocialCubit.get(context).model?.uId == message.senderId) {
//                               return buildMyMessage(message);
//                             }
//
//                             return buildMessage(message);
//                           },
//                           separatorBuilder: (context, index) => SizedBox(
//                             height: 15.0,
//                           ),
//                           itemCount: SocialCubit.get(context).messages.length,
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey,
//                             width: 1.0,
//                           ),
//                           borderRadius: BorderRadius.circular(
//                             15.0,
//                           ),
//                         ),
//                         clipBehavior: Clip.antiAliasWithSaveLayer,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 15.0,
//                                 ),
//                                 child: TextFormField(
//                                   controller: messageController,
//                                   decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: 'type your message here ...',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               height: 50.0,
//                               color: Colors.blue,
//                               child: MaterialButton(
//                                 onPressed: () {
//                                   SocialCubit.get(context).sendMessage(
//                                     receiverId: userModel!.uId!,
//                                     dateTime: DateTime.now().toString(),
//                                     text: messageController.text,
//                                   );
//                                 },
//                                 minWidth: 1.0,
//                                 child: Icon(
//                                   IconBroken.Send,
//                                   size: 16.0,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 fallback: (context) => Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget buildMessage(MessageModel? model) => Align(
//     alignment: AlignmentDirectional.centerStart,
//     child: Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadiusDirectional.only(
//           bottomEnd: Radius.circular(
//             10.0,
//           ),
//           topStart: Radius.circular(
//             10.0,
//           ),
//           topEnd: Radius.circular(
//             10.0,
//           ),
//         ),
//       ),
//       padding: EdgeInsets.symmetric(
//         vertical: 5.0,
//         horizontal: 10.0,
//       ),
//       child: Text(
//         model!.text!,
//       ),
//     ),
//   );
//
//   Widget buildMyMessage(MessageModel? model) => Align(
//     alignment: AlignmentDirectional.centerEnd,
//     child: Container(
//       decoration: BoxDecoration(
//         color: Colors.blue.withOpacity(
//           .2,
//         ),
//         borderRadius: BorderRadiusDirectional.only(
//           bottomStart: Radius.circular(
//             10.0,
//           ),
//           topStart: Radius.circular(
//             10.0,
//           ),
//           topEnd: Radius.circular(
//             10.0,
//           ),
//         ),
//       ),
//       padding: EdgeInsets.symmetric(
//         vertical: 5.0,
//         horizontal: 10.0,
//       ),
//       child: Text(
//         model!.text!,
//       ),
//     ),
//   );
// }