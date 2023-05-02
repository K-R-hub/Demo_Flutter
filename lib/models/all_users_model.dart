class SocialAllUsersModel{
  String? name;
  String? email;
  String? password;
  String? image;
  String? cover;
  String? phone;
  String? uId;
  String? bio;
  bool? isEmailVerified;

  SocialAllUsersModel({
    required this.name,
    required this.email,
    required this.password,
    required this.image,
    required this.cover,
    required this.bio,
    required this.phone,
    required this.uId,
    required this.isEmailVerified
  });

  SocialAllUsersModel.fromJson(Map<String , dynamic>? json){
    name = json?['name'];
    email = json?['email'];
    password = json?['password'];
    phone = json?['phone'];
    image = json?['image'];
    cover = json?['cover'];
    bio = json?['bio'];
    uId = json?['uId'];
    isEmailVerified = json?['isEmailVerified'];

  }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'email':email,
      'password':password,
      'image':image,
      'cover':cover,
      'bio':bio,
      'phone':phone,
      'uId':uId,
      'isEmailVerified':isEmailVerified,

    };
  }
}