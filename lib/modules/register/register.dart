import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/login.dart';
import 'package:social_app/modules/register/cubit/cubit.dart';
import 'package:social_app/modules/register/cubit/states.dart';
import '../../../shared/components/components.dart';


class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  SocialRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if(state is SocialCreateUserSuccessState){
            goToScreenAndFinish(context, SocialLoginScreen());
          }

        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style:
                          Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to Social App',
                          style:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox( height: 30.0,),
                        defaultFormField(
                          textControl: nameController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Name',
                          prefix: const Icon(Icons.person),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Your Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox( height: 15.0,),
                        defaultFormField(
                          textControl: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email',
                          prefix: const Icon(Icons.email_outlined),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15.0,),
                        defaultFormField(
                          textControl: phoneController,
                          keyboardType: TextInputType.phone,
                          label: 'Phone',
                          prefix: const Icon(Icons.email_outlined),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Your Phone';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15.0,),
                        defaultFormField(
                          textControl: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: const Icon(Icons.lock),
                          suffix: SocialRegisterCubit.get(context).suffix,
                          obscureText:
                          SocialRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSubmit: (v) {
                            if (formKey.currentState!.validate()) {
                              // SocialRegisterCubit.get(context).userRegister(
                              //   name: nameController.text,
                              //   phone: phoneController.text,
                              //   email: emailController.text,
                              //   password: passwordController.text,
                              // );
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30.0, ),
                        state is! SocialRegisterLoadingState
                            ? defaultButton(
                            onpressed: () {
                              if (formKey.currentState!.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register')
                            : const Center(child: CircularProgressIndicator()),
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
