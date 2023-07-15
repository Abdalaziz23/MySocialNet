import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).model != null,
          builder:(context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children:
              [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: const  EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                          'https://img.freepik.com/free-photo/photo-contemplative-woman-with-afro-hairstyle-wears-round-spectacles-casual-warm-sweater_273609-18044.jpg?w=740&t=st=1681608228~exp=1681608828~hmac=a168b77d3f11857f540b4f64c8b6ba80327e453c4275f8b5a8fdc81ee8e07a16',
                        ),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate with friends',
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  separatorBuilder: (context,index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          fallback:(context) =>const Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }
  Widget buildPostItem(PostModel? postModel,context,index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Row(
            children:[
               CircleAvatar(
                backgroundImage: NetworkImage(
                  '${SocialCubit.get(context).model?.image}',
                ),
                radius: 25,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:  [
                        Text(
                          '${SocialCubit.get(context).model?.name}',
                          style: TextStyle(
                            height:1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16,
                        ),
                      ],
                    ),
                    Text(
                      '${postModel?.dateTime}',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 18,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical:10,
            ),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${postModel?.text}',
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
              height:1.4 ,
              fontSize: 16,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsetsDirectional.only(
          //     top: 10,
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(
          //             end: 5,
          //           ),
          //           child: Container(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               height: 25,
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child:  Text(
          //                 '#software ',
          //                 style: Theme.of(context).textTheme.caption?.copyWith(
          //                   color: Colors.blue,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(postModel?.postImage != '')
            Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 16,
            ),
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(4) ,
                image: DecorationImage(
                  image:NetworkImage(
                    '${postModel?.postImage}',
                  ) ,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: 8,
                      top: 8,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          size: 18,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${SocialCubit.get(context).likes[index]}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              Expanded(
                child: InkWell(
                  onTap: (){},
                  child: Padding(
                    padding:const EdgeInsetsDirectional.only(
                      bottom: 8,
                      top: 8,
                    ) ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          IconBroken.Chat,
                          size: 18,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '0 comments ',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){},
                  child: Row(
                    children:[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).model?.image}',
                        ),
                        radius: 15,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Write a comment ...',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: ()
                {
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 5,
                    top: 5,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        size: 18,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
