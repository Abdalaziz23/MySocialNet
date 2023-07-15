import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/component.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  //const NewPostScreen({Key? key}) : super(key: key);
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: const Text(
              'Create Post',
            ),
            leading: IconButton(
              onPressed:()
              {
                Navigator.pop(context);
              } ,
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            actions: [
              defaultTextButton(
                onPressed: ()
                {
                  var now = DateTime.now();
                  if(SocialCubit.get(context).postImage == null)
                  {
                    SocialCubit.get(context).createPost(
                        dateTime: now.toString(),
                        text: textController.text,
                    );
                  }else
                  {
                    SocialCubit.get(context).uploadPostImage(
                        dateTime: now.toString(),
                        text: textController.text,
                    );
                  }
                },
                text: 'post',
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/premium-photo/woman-dances-with-arms-raised-up-smiles-broadly-catches-every-bit-music-wears-casual-t-shirt-poses-against-pink-expresses-positive-emotions_273609-56567.jpg',
                      ),
                      radius: 25,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Abdalaziz Mohammed',
                        style: TextStyle(
                          height:1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:  BorderRadius.circular(4),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(SocialCubit.get(context).postImage!),
                        ) ,
                      ),
                    ),
                    IconButton(
                      onPressed: ()
                      {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: const CircleAvatar(
                        backgroundColor: Colors.black38,
                        radius: 20,
                        child: Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: ()
                        {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Icon(
                                IconBroken.Image
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                'Add Photo'
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child:Text(
                            '# Tags'
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
  }
}
