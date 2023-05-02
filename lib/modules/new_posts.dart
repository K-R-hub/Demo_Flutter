import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import '../shared/components/components.dart';

class NewPostsScreen extends StatelessWidget {
   NewPostsScreen({Key? key}) : super(key: key);
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialSates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Create Posts',
              actions: [
                TextButton(
                  onPressed: () {
                    if(cubit.imagePostPicker != null){
                      cubit.uploadNewPost(dataTime: DateTime.now().toString(),text: textController.text );
                    }else{
                      cubit.createPosts(text: textController.text, dataTime: DateTime.now().toString());
                    }
                  },
                  child: const Text(
                    'Post',
                  ),
                ),
              ]
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialPostLoadingState)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: LinearProgressIndicator(),
                  ),
                Row(
                  children: [
                     CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        cubit.userModel!.image!,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'Karim Habboub',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(),
                      ),
                    ),


                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    maxLines: null,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'What is on your mind ${cubit.userModel?.name}',


                    ),
                  ),
                ),
                if(cubit.imagePostPicker != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image:  DecorationImage(
                              image:FileImage(cubit.imagePostPicker!),
                              fit: BoxFit.cover,
                            )

                        ),


                      ),
                      IconButton(
                        onPressed: () {
                          cubit.removeImagePost();
                        },
                        icon: const Icon(
                            Icons.close
                        ),


                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubit.getImagePostPicker();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.Image),
                            SizedBox(width: 5,),
                            Text(
                              'add photo'
                            ),
                          ],

                      ),),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child:const Text(
                              '# tags'
                            ),


                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
