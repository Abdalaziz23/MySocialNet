import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/component.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        var userModel = SocialCubit.get(context).model;
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 240,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment:AlignmentDirectional.topStart,
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight:Radius.circular(4),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              '${userModel?.cover}',

                            ),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 78,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage: NetworkImage(
                          '${userModel?.image}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${userModel?.name}',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  height:2,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '${userModel?.bio}',
                style: Theme.of(context).textTheme.caption?.copyWith(
                  height:1.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical:20 ,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                height:1.5,
                              ),
                            ),
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
                              '270',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                height:1.5,
                              ),
                            ),
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
                              '100 k',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                height:1.5,
                              ),
                            ),
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
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                height:1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child:OutlinedButton(
                      onPressed: (){},
                      child: Text(
                        'Add Photos',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  OutlinedButton(
                    onPressed: ()
                    {
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(
                      IconBroken.Edit,
                      size: 16,
                    ),
                  )
                ],
              ),
            ],
          ),
        ) ;
      },
    );
  }
}