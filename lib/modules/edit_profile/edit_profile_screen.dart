import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/social_login/cubit/cubit.dart';
import 'package:social_app/shared/components/component.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  //const EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).model;
       // var cubit = SocialCubit.get(context);
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Text(
              'Edit Profile',
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            actions: [
              defaultTextButton(
                onPressed: ()
                {
                  SocialCubit.get(context).updateUser(name: nameController.text, bio: bioController.text);
                },
                text: 'Update',
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // if(state is SocialUserUpdateLoadingStates)
                  //   LinearProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 240,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 180,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: coverImage == null ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      '${userModel?.cover}',
                                    ),
                                  ) :DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(coverImage),
                                  ) ,
                                ),
                              ),
                              IconButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar(
                                  backgroundColor: Colors.black38,
                                  radius: 20,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children:<Widget> [
                            // cubit.profileImage == null ? CircleAvatar(
                            //   radius: 60,
                            //   backgroundColor: Colors.red,
                            //   backgroundImage: NetworkImage(userModel!.image!),
                            // ) :
                            // CircleAvatar(
                            //   radius: 50,
                            //         backgroundImage:
                            //             FileImage(cubit.profileImage!),
                            //       ),
                            profileImage == null ? CircleAvatar(
                              radius: 78,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage:NetworkImage(
                                  '${userModel?.image}',
                                ) ,
                              ),
                            ):
                            CircleAvatar(
                              radius: 78,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage:FileImage(profileImage) ,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                backgroundColor: Colors.black38,
                                radius: 20,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null  )
                    Row(
                    children: [
                      if(SocialCubit.get(context).profileImage != null)
                        Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                function: ()
                                {
                                  SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                  );
                                },
                                text: 'upload profile',
                            ),
                            if(state is SocialUserUpdateLoadingStates)
                              const SizedBox(
                                height: 5,
                              ),
                            if(state is SocialUserUpdateLoadingStates)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      if(SocialCubit.get(context).coverImage != null)
                        Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                function: ()
                                {
                                  SocialCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    bio: bioController.text,
                                  );
                                },
                                text: 'upload cover',
                            ),
                            if(state is SocialUserUpdateLoadingStates)
                              const SizedBox(
                              height: 5,
                            ),
                            if(state is SocialUserUpdateLoadingStates)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null  )
                    const SizedBox(
                    height: 16,
                  ),
                  defaultFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name must not be empty';
                      }
                      return null;
                    },
                    labelText: 'Name',
                    prefix: IconBroken.User,
                  ),
                   SizedBox(
                    height: 16,
                  ),
                  defaultFormField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Bio must not be empty';
                      }
                      return null;
                    },
                    labelText: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
