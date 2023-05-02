
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/modules/login/cubit/states.dart';

import '../../../shared/components/constant.dart';
import '../../../shared/network/local/cache_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffixIcon = Icons.remove_red_eye_outlined;

  void changIsPassword() {
    isPassword = !isPassword;
    suffixIcon = isPassword
        ? Icons.remove_red_eye_outlined
        : Icons.visibility_off_outlined;
    emit(SocialLoginChangeVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      uId =  value.user?.uid;

      emit(SocialLoginSuccessState(value.user?.uid));

    }).catchError((onError) {
      print(onError.toString());
      emit(SocialLoginErrorState(onError.toString()));
    });
  }
}
