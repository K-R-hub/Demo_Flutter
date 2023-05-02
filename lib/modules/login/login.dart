
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:social_app/modules/register/register.dart';

import '../../../shared/network/local/cache_helper.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/social_layout.dart';
import '../../shared/components/components.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (BuildContext context, state) {
          if(state is SocialLoginErrorState){
            showToast(
                msg: state.error,
                state: ToastState.ERROR
            );
          }else if (state is SocialLoginSuccessState ){
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              SocialCubit.get(context).getUserData();
              goToScreenAndFinish(context, SocialLayout());

            });
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style:
                          Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login now to Social App',
                          style:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          textControl: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'email',
                          prefix: Icon(Icons.email_outlined),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          textControl: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          label: 'password',
                          prefix: Icon(Icons.lock),
                          suffix: SocialLoginCubit.get(context).suffixIcon,
                          obscureText: SocialLoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            SocialLoginCubit.get(context).changIsPassword();
                          },
                          onSubmit: (v) {
                            if (formkey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        state is! SocialLoginLoadingState
                            ? defaultButton(
                          onpressed: () {
                            if (formkey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: 'login',
                        )
                            : Center(child: CircularProgressIndicator()),
                        SizedBox(
                          height: 22,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                goToScreen(
                                  context,
                                  SocialRegisterScreen(),
                                );
                              },
                              child: Text(
                                'REGISTER',
                              ),
                            )
                          ],
                        )
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
