import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chat_details/chat_details_screen.dart';
import 'package:social_app/modules/search/search-screen.dart';
import 'package:social_app/shared/components/component.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) => ListView.separated(
            itemBuilder: (context,index) => buildChatItem(SocialCubit.get(context).users[index],context),
            separatorBuilder: (context,index) => myDivider(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ) ;
      },
    );
  }
  Widget buildChatItem(SocialUserModel? model,context) =>  InkWell(
    onTap: ()
    {
      navigateTo(context, ChatDetailsScreen(
        socialUserModel: model,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children:[
          CircleAvatar(
            backgroundImage: NetworkImage(
              '${model?.image}',
            ),
            radius: 25,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            '${model?.name}',
            style: TextStyle(
              height:1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}