import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/all_users_model.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import '../shared/style/colors.dart';

class ChatsDetailsScreen extends StatelessWidget {
  SocialAllUsersModel? userModel;

  ChatsDetailsScreen(this.userModel, {Key? key}) : super(key: key);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getMessages(receiver: userModel!.uId);

      return BlocConsumer<SocialCubit, SocialSates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(userModel!.image!),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(userModel!.name!,
                          style: const TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  right: 20,
                  left: 20,
                  bottom: 1,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        controller: cubit.scrollController,
                        itemBuilder: (context, index) {
                          var message = cubit.messages[index];
                          if (cubit.userModel!.uId != message.sender) {
                            return friendMessage(message);
                          } else
                            return myMessage(message);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: cubit.messages.length,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: messageController,
                          maxLines: null,
                          autovalidateMode: AutovalidateMode.always,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'The message',
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  cubit.sendMessage(
                                      receiver: userModel!.uId,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                  messageController.clear();
                                  await Future.delayed(
                                      const Duration(milliseconds: 100));
                                  cubit.scrollToBottom();
                                },
                                icon: const Icon(
                                  IconBroken.Send,
                                  color: defaultColor,
                                ),
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              )
              );
        },
      );
    });
  }

  Widget myMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(.2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Text(
            message.text!,
          ),
        ),
      );

  Widget friendMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            ),
          ),
          child: Text(
            message.text!,
          ),
        ),
      );
}
