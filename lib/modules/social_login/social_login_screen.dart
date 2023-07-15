import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_login/cubit/cubit.dart';
import 'package:social_app/modules/social_login/cubit/states.dart';
import 'package:social_app/modules/social_register/social_register_screen.dart';
import 'package:social_app/shared/components/component.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  //const SocialLoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController =TextEditingController();
  var passwordController =TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: ( context,  state)
        {
          if(state is SocialLoginErrorStates)
          {
            showToast(
                text: state.error,
                state: ToastStates.error,
            );
          }
          if(state is SocialLoginSuccessStates)
          {
            CacheHelper.savedData(
                key: 'uId',
                value: state.uId,
            ).then((value)
            {
              navigateAndFinish(context, SocialLayout());
            });
          }
        },
        builder: ( context,  state){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Social App',
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                          'login now to communicate with friends',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Enter Your Email';
                            }
                            return null;
                          },
                          labelText: 'Email Address',
                          prefix: Icons.email,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          suffix: SocialLoginCubit.get(context).suffix,
                          keyboardType: TextInputType.visiblePassword,
                          onPressed: ()
                          {
                            SocialLoginCubit.get(context).changeVisibilityPassword();
                          },
                          obscureText:SocialLoginCubit.get(context).isPassword,
                          onFieldSubmit: (value){
                            if(formKey.currentState!.validate())
                            {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validator: (value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          labelText: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          fallback: (context)=>const Center(child: CircularProgressIndicator()),
                          condition: state is! SocialLoginLoadingStates,
                          builder: (context)=> defaultButton(
                            function: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'LOGIN',
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              onPressed: ()
                              {
                                navigateTo(context, SocialRegisterScreen());
                              },
                              text: 'Register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
