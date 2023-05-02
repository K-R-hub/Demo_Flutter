import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/all_users_model.dart';
import 'package:social_app/modules/chats_details.dart';
import 'package:social_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialSates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return cubit.users.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildChatItem(model: cubit.users[index], context: context),
                    separatorBuilder: (context, index) =>
                        Container(height: 1, color: Colors.grey),
                    itemCount: cubit.users.length),
              )
            : const Center(child: Text('No Users'));
      },
    );
  }

  Widget buildChatItem({required SocialAllUsersModel model, context}) =>
      InkWell(
        onTap: () {
          goToScreen(context, ChatsDetailsScreen(model));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(model.image!),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(model.name!, style: TextStyle()),
              ),
            ],
          ),
        ),
      );
}
