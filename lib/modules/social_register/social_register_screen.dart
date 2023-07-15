import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_register/cubit/cubit.dart';
import 'package:social_app/modules/social_register/cubit/states.dart';
import 'package:social_app/shared/components/component.dart';

class SocialRegisterScreen extends StatelessWidget {
  //const SocialRegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: ( context,  state)
        {
          if(state is SocialRegisterErrorStates)
          {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
          if(state is SocialCreateUserSuccessStates)
          {
            navigateAndFinish(context, SocialLayout());
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
                          'REGISTER',
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
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Enter Your Name';
                            }
                            return null;
                          },
                          labelText: 'User Name',
                          prefix: Icons.person,
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
                          suffix: SocialRegisterCubit.get(context).suffix,
                          keyboardType: TextInputType.visiblePassword,
                          onPressed: ()
                          {
                            SocialRegisterCubit.get(context).changeVisibilityPassword();
                          },
                          obscureText:SocialRegisterCubit.get(context).isPassword,
                          onFieldSubmit: (value){
                            if(formKey.currentState!.validate())
                            {
                              SocialRegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name:nameController.text ,
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
                          condition: state is! SocialRegisterLoadingStates,
                          builder: (context)=> defaultButton(
                            function: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                SocialRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name:nameController.text ,
                                );
                              }
                            },
                            text: 'register',
                          ),
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
