import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/cubit/states.dart';

import '../../../models/user_model.dart';
import '../../../shared/network/local/cache_helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      CacheHelper.saveData(
          key: 'uId',
          value:value.user?.uid,
      );

      createUser(
        name: name,
        email: email,
        password: password,
        phone: phone,
        myId: value.user!.uid,
      );
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialRegisterErrorState(onError.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String myId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      password: password,
      phone: phone,
      uId: myId,
      isEmailVerified: false,
      cover:'https://img.freepik.com/free-photo/emotions-lifestyle-concept-happy-delighted-dark-skinned-curly-woman-wears-white-sweatshirt-laughs-has-fun-looks-aside_273609-39195.jpg?w=900&t=st=1680860864~exp=1680861464~hmac=5e037cdb829349d2c503b125a9c44fa31890c027d88f97affd4c40d7a01e1805',
      bio: 'My bio is ...',
      image: 'https://img.freepik.com/premium-photo/smiling-old-woman-her-face-lit-up-with-happiness-short-white-hair-rosy-cheeks-brown-ribbon-her-hair-large-earrings-generated-ai_501669-26093.jpg?w=996',
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(myId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialCreateUserErrorState(onError.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
