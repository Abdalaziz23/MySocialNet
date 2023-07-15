import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_login/social_login_screen.dart';
import 'package:social_app/shared/block_observer.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'package:social_app/shop_app_cubit/cubit.dart';
import 'package:social_app/shop_app_cubit/states.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if(uId != null)
  {
    widget = SocialLayout();
  }else
  {
    widget = SocialLoginScreen();
  }
  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  final Widget  startWidget;
  MyApp(this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopAppCubit(),
        ),
        BlocProvider(
            create: (context) => SocialCubit()..getUserData()..getPosts(),
        ),
      ],
      child: BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: (context,state){},
        builder:(context,state)
        {
          return Sizer(
              builder: (context, orientation, deviceType) {
                return MaterialApp(
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  debugShowCheckedModeBanner: false,
                  home: startWidget,
                );
              }
          )  ;
        } ,
      ),
    );
  }
}

