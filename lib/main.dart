import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/style/themes.dart';
import 'layout/cubit/cubit.dart';
import 'layout/social_layout.dart';
import 'modules/login/login.dart';



Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  showToast(msg: "on Background messages", state: ToastState.SUCCESS);
  print(message.data.toString());
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(msg: "onMessage", state: ToastState.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(msg: "onMessageOpenedApp", state: ToastState.SUCCESS);

  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? isDark = CacheHelper.getData(key: 'isDark');
  //bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: "uId");
  print(uId);
  //token = CacheHelper.getData(key: 'token');
  //print(token);

  // if(onBoarding != null){
  //   if(token != null) widget = ShopLayout();
  //  else widget = ShopLoginScreen();
  // }else widget = onBoardingScreen();
  if(uId != null){
    widget = const SocialLayout();
  }else{ widget = SocialLoginScreen();};


  runApp(MyApp(isDark,widget));
}

class MyApp extends StatelessWidget {
  bool? isDark;
  Widget startWidget;
  MyApp(
      this.isDark,
      this.startWidget,
      );
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => AppCubit()..changeMode(stateMode: isDark)
          ),

          BlocProvider(
              create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()
          ),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, Object? state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: AppCubit.get(context).isDark
                    ? ThemeMode.light
                    : ThemeMode.dark,
                home:startWidget,
              );
            }));
  }
}
