import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/style/icon_broken.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialSates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          var imageProfilePicker = cubit.imageProfilePicker;
          var imageCoverPicker = cubit.imageCoverPicker;
          var model = cubit.userModel;
          nameController.text = model!.name!;
          bioController.text = model.bio!;
          phoneController.text = model.phone!;

          ImageProvider<Object>? imageProfile(){
            if(imageProfilePicker == null){
              return  NetworkImage(
                SocialCubit.get(context).userModel!.image!,
              );
            }else {
              return FileImage(
                imageProfilePicker
            );
            }
          }
             ImageProvider<Object> imageCover(){
                if(imageCoverPicker == null){
                  return  NetworkImage(
                    SocialCubit.get(context).userModel!.cover!,
                  );
                }else {
                  return FileImage(
                    imageCoverPicker
                );
                }
          }

          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                TextButton(
                  onPressed: () {
                    cubit.updateUser(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                  },
                  child: const Text(
                    'UPDATE',
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState || state is SocialUploadImageLoadingState)
                     const Padding(
                       padding: EdgeInsets.symmetric(vertical: 20),
                       child: LinearProgressIndicator(),
                     ),
                  SizedBox(
                    height: 230,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                                width: double.infinity,
                                height: 180,
                                decoration:  BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    image:imageCover(),
                                    fit: BoxFit.cover,

                                ),
                                ),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 18,
                                child: IconButton(
                                  onPressed: () {
                                    cubit.getImageCoverPicker().then((value) {
                                      cubit.uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                                    }).catchError((onError){
                                      print(onError);
                                    });


                                  },
                                  icon: const Icon(
                                    IconBroken.Camera,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                               CircleAvatar(
                                radius: 64,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: imageProfile(),
                                ),
                              ),
                              CircleAvatar(
                                radius: 18,
                                child: IconButton(
                                  onPressed: () {
                                    cubit.getImageProfilePicker().then((value) {
                                      cubit.uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                                    }).catchError((onError){
                                      print(onError);
                                    });
                                  },
                                  icon: const Icon(
                                    IconBroken.Camera,
                                    size: 20,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  defaultFormField(
                    textControl: nameController,
                    keyboardType: TextInputType.name,
                    label: 'Name',
                    prefix: const Icon(IconBroken.User),
                    validator: (String? v){
                      if(v== null || v.isEmpty ){
                        return 'It must not be empty';
                      }return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  defaultFormField(
                    textControl: bioController,
                    keyboardType: TextInputType.text,
                    label: 'Bio',
                    prefix: const Icon(IconBroken.Info_Circle),
                    validator: (String? v){
                      if(v== null || v.isEmpty ){
                        return 'It must not be empty';
                      }return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  defaultFormField(
                    textControl: phoneController,
                    keyboardType: TextInputType.phone,
                    label: 'Phone',
                    prefix: const Icon(IconBroken.Call),
                    validator: (String? v){
                      if(v== null || v.isEmpty ){
                        return 'It must not be empty';
                      }return null;
                    },
                  ),
                ],
              ),
            ),
          );
        }

    );

  }

}
