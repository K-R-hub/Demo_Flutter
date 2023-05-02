import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/chats.dart';
import 'package:social_app/modules/feeds.dart';
import 'package:social_app/modules/new_posts.dart';
import 'package:social_app/modules/settings.dart';
import 'package:social_app/modules/users.dart';

import '../../models/all_users_model.dart';
import '../../models/user_model.dart';
import '../../modules/login/login.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/network/local/cache_helper.dart';

class SocialCubit extends Cubit<SocialSates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection("users").doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(SocialGetUserErrorState(onError.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    const ChatsScreen(),
    NewPostsScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  void changeCurrentIndex(int index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(BottomChangeNavState());
    }
  }

  List<Widget> title = [
    const Text('Home'),
    const Text('Chats'),
    const Text('Posts Screen'),
    const Text('Users'),
    const Text('Settings'),
  ];

  final picker = ImagePicker();

  File? imageProfilePicker;

  Future<void> getImageProfilePicker() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageProfilePicker = File(pickedFile.path);
      emit(SocialGetImageProfilePickerSuccessState());
    } else {
      emit(SocialGetImageProfilePickerErrorState());
    }
  }

  File? imageCoverPicker;

  Future<void> getImageCoverPicker() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageCoverPicker = File(pickedFile.path);
      emit(SocialGetImageCoverPickerSuccessState());
    } else {
      emit(SocialGetImageCoverPickerErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUploadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageProfilePicker!.path).pathSegments.last}')
        .putFile(imageProfilePicker!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        userModel?.image = value;
        updateUser(name: name, phone: phone, bio: bio);
        emit(SocialUploadImageProfileSuccessState());
      }).catchError((onError) {
        emit(SocialUploadImageProfileErrorState());
      });
    }).catchError((onError) {
      emit(SocialUploadImageProfileErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUploadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageCoverPicker!.path).pathSegments.last}')
        .putFile(imageCoverPicker!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        userModel?.cover = value;
        updateUser(name: name, phone: phone, bio: bio);
        emit(SocialUploadImageCoverSuccessState());
      }).catchError((onError) {
        emit(SocialUploadImageCoverErrorState());
      });
    }).catchError((onError) {
      emit(SocialUploadImageCoverErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    userModel?.name = name;
    userModel?.phone = phone;
    userModel?.bio = bio;

    // print(userModel?.name);
    // print(userModel?.email);
    // print(userModel?.phone);
    // print(userModel?.password);
    // print(userModel?.uId);
    // print(userModel?.isEmailVerified);
    // print(userModel?.image);
    // print(userModel?.cover);
    // print(userModel?.bio);

    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel?.uId)
        .update(userModel!.toMap())
        .then((value) {
      getUserData();
    }).catchError((onError) {});
  }

// New Posts Screen
  File? imagePostPicker;

  Future<void> getImagePostPicker() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePostPicker = File(pickedFile.path);
      emit(SocialGetImagePostPickerSuccessState());
    } else {
      emit(SocialGetImagePostPickerErrorState());
    }
  }

  void removeImagePost() {
    imagePostPicker = null;
    emit(SocialRemoveImagePostPickerState());
  }

  void uploadNewPost({required String? text, required String? dataTime}) {
    emit(SocialPostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child(
          'posts/${Uri.file(imagePostPicker!.path).pathSegments.last}',
        )
        .putFile(imagePostPicker!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPosts(text: text, postImage: value, dataTime: dataTime);
      }).catchError((onError) {
        emit(SocialUploadPostImageErrorState());
      });
    }).catchError((onError) {
      emit(SocialUploadPostImageErrorState());
    });
  }

  // String? name;
  // String? image;
  // String? postImage;
  // String? uId;
  // String? text;
  // String? dataTime;
  void createPosts({
    required String? text,
    String? postImage,
    required String? dataTime,
  }) {
    posts = [];
    postsId = [];
    likes = {};
    comments = {};
    emit(SocialPostLoadingState());
    PostModel postModel = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dataTime: dataTime,
      text: text,
      postImage: postImage,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(value.id)
          .update({"pId": value.id}).then((value) {
        getPosts();
      });
    }).catchError((onError) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  Map<String, int> likes = {};
  Map<String, int> comments = {};

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likes[element.id] = value.docs.length;
        }).catchError((onError) {
          emit(SocialGetPostsErrorState(onError.toString()));
        });
        element.reference.collection('comments').get().then((value) {
          comments[element.id] = value.docs.length;
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetPostsSuccessState());
        }).catchError((onError) {
          emit(SocialGetPostsErrorState(onError.toString()));
        });
      }
    }).catchError((onError) {
      emit(SocialGetPostsErrorState(onError.toString()));
    });
  }

  void likePost({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikeSuccessState());
    }).catchError((onError) {
      emit(SocialLikeErrorState(onError.toString()));
    });
  }

  void commentPost(
      {required String postId, required String commentController}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({'comment': commentController}).then((value) {
      emit(SocialCommentSuccessState());
    }).catchError((onError) {
      emit(SocialCommentErrorState(onError.toString()));
    });
  }

  List<SocialAllUsersModel> users = [];

  void getAllUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel?.uId) {
            users.add(SocialAllUsersModel.fromJson(element.data()));
          }
          emit(SocialGetAllUsersSuccessState());
        }
      }).catchError((onError) {
        emit(SocialGetAllUsersErrorState(onError.toString()));
      });
    }
  }

  // Chats details
  void sendMessage({
    required String? receiver,
    required String? dateTime,
    required String? text,
  }) {
    MessageModel messageModel = MessageModel(
        sender: userModel!.uId,
        receiver: receiver,
        text: text,
        dateTime: dateTime);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiver)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((onError) {
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiver)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((onError) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String? receiver,
  }) {


    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiver)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          for (var element in event.docs) {
            messages.add(MessageModel.fromJson(element.data()));
          }
          emit(SocialGetMessageSuccessState());
    });
  }
// scroll To Bottom
 final ScrollController scrollController = ScrollController();
  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    ).then((value) {
      emit(SocialScrollToBottomSuccessState());
    });
  }





// تسجيل الخروج
  void signOut(context){
    CacheHelper.removeData(key: 'uId').then((value) {
      goToScreenAndFinish(context,SocialLoginScreen());
    });
  }














}


//https://scontent.fgza6-1.fna.fbcdn.net/v/t31.18172-8/12469616_896134003840653_67979338890599594_o.jpg?_nc_cat=102&ccb=1-7&_nc_sid=e3f864&_nc_ohc=xe6t51i4QPcAX9u116U&_nc_ht=scontent.fgza6-1.fna&oh=00_AfBJN8YJCMsHrwXamOzek1uLWhRvRNVeDNYy_jOr7gp3yQ&oe=645C885B
