import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/edit_profil.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialSates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 230,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(cubit.userModel!.cover!),
                            fit: BoxFit.cover,
                          ),
                        )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        radius: 64,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(cubit.userModel!.image!),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                cubit.userModel!.name!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                cubit.userModel!.bio!,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '64',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '10K',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '64',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Add Photos',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      goToScreen(context, EditProfile());
                    },
                    child: const Icon(
                      IconBroken.Edit,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      FirebaseMessaging.instance.subscribeToTopic('subscription');
                    },
                    child: Text(
                      'subscription',
                    ),
                  ),
                  SizedBox(width: 20,),
                  OutlinedButton(
                    onPressed: () {
                      FirebaseMessaging.instance.unsubscribeFromTopic('subscription');
                    },
                    child: Text(
                      'unsubscribe',
                    ),
                  ),
                  SizedBox(width: 20,),
                  OutlinedButton(
                    onPressed: () {
                      cubit.signOut(context);
                    },
                    child: Text(
                      'تسديل الخروج',
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
