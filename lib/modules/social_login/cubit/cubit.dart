import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_login/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginInitialStates());
  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
  required String email,
  required String password,
})
  {
    emit(SocialLoginLoadingStates());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value)
    {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoginSuccessStates(value.user!.uid));
    }).catchError((error){
      print(error.toString());
      emit(SocialLoginErrorStates(error.toString()));
    });
  }

  IconData? suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changeVisibilityPassword()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibilityStates());
  }

}