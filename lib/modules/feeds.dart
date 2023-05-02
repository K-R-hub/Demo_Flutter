import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/style/colors.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import '../models/post_model.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({Key? key}) : super(key: key);
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialSates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SocialCubit.get(context).posts.isNotEmpty &&
                SocialCubit.get(context).userModel != null
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      elevation: 10,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          const Image(
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'https://img.freepik.com/free-photo/emotions-lifestyle-concept-happy-delighted-dark-skinned-curly-woman-wears-white-sweatshirt-laughs-has-fun-looks-aside_273609-39195.jpg?w=900&t=st=1680860864~exp=1680861464~hmac=5e037cdb829349d2c503b125a9c44fa31890c027d88f97affd4c40d7a01e1805',
                              )),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10.0, right: 5.0),
                            child: Text(
                              'Communicat With Friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildPostItem(
                          SocialCubit.get(context).posts[index],
                          context,
                          index),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8.0,
                      ),
                      itemCount: SocialCubit.get(context).posts.length,
                    )
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildPostItem(PostModel model, context, int index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(model.image!,),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              model.name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 15,
                            ),
                          ],
                        ),
                        Text(
                          model.dataTime!,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                height: 1.7,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_horiz)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  height: 1,
                ),
              ),
              if (model.text != null)
                Text(
                  model.text!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontSize: 15),
                ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(right: 10),
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                   '#_here we are',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .caption
              //                       ?.copyWith(
              //                       color: defaultColor, fontSize: 16)),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(right: 10),
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                   '#_here we are',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .caption
              //                       ?.copyWith(
              //                       color: defaultColor, fontSize: 16)),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if (model.postImage != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15),
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(
                            model.postImage!,
                          ),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${SocialCubit.get(context).likes[SocialCubit.get(context).postsId[index]]}',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          IconBroken.Chat,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${SocialCubit.get(context).comments[SocialCubit.get(context).postsId[index]]} comments',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  height: 1,
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      SocialCubit.get(context).userModel!.image!,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  // Text(
                  //   'write comment... ',
                  //   style: Theme
                  //       .of(context)
                  //       .textTheme
                  //       .subtitle1,
                  // ),
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        TextFormField(
                          controller: commentController,
                          keyboardType: TextInputType.text,
                          maxLines: null,
                          autovalidateMode: AutovalidateMode.always,
                          decoration: InputDecoration(
                            hintText: 'Write your comment',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            SocialCubit.get(context).commentPost(
                                postId: SocialCubit.get(context).postsId[index],
                                commentController: commentController.text);
                            commentController.clear();
                          },
                          icon: const Icon(
                            Icons.send,
                            size: 20,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          SocialCubit.get(context).likePost(
                              postId: SocialCubit.get(context).postsId[index]);
                        },
                        icon: const Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                        ),
                      ),
                      const Text(
                        'Like',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
