import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialStates());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
  required String name,
  required String email,
  required String password,
})
  {
    emit(SocialRegisterLoadingStates());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value)
    {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        uId: value.user!.uid,
        name:name,
        email: email,
      );
      // emit(SocialRegisterSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(SocialRegisterErrorStates(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String uId,
})
  {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      uId: uId,
      isEmailVerified: false,
      bio: 'write you bio ...',
      image: 'https://img.freepik.com/free-photo/curly-ethnic-woman-shows-manicured-yellow-nails-has-glad-expression-smiles-happily-glad-after-visiting-manicurist-wears-casual-orange-jumper-isolated-purple-wall-keeps-hands-raised_273609-42663.jpg?t=st=1681735282~exp=1681735882~hmac=1e934405acf0aa0357e36bdb682a8ebc366c439ea0c244589060aaf540c8cc90',
      cover: 'https://img.freepik.com/free-photo/curly-ethnic-woman-shows-manicured-yellow-nails-has-glad-expression-smiles-happily-glad-after-visiting-manicurist-wears-casual-orange-jumper-isolated-purple-wall-keeps-hands-raised_273609-42663.jpg?t=st=1681735282~exp=1681735882~hmac=1e934405acf0aa0357e36bdb682a8ebc366c439ea0c244589060aaf540c8cc90',
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value)
    {
      emit(SocialCreateUserSuccessStates());
    }).catchError((error)
    {
      emit(SocialCreateUserErrorStates(error.toString()));
    });
  }

  IconData? suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changeVisibilityPassword()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityStates());
  }


}