class PostModel{
  String? name;
  String? image;
  String? postImage;
  String? uId;
  String? pId;
  String? text;
  String? dataTime;



  PostModel({
    required this.name,
    required this.image,
    required this.uId,
    this.pId,
    this.postImage,
    this.text,
    required this.dataTime,
  });

  PostModel.fromJson(Map<String , dynamic>? json){
    name = json?['name'];
    image = json?['image'];
    uId = json?['uId'];
    pId = json?['pId'];
    postImage = json?['postImage'];
    text = json?['text'];
    dataTime = json?['dataTime'];




  }

  Map<String , dynamic> toMap(){
    return{
      'name':name,
      'image':image,
      'uId':uId,
      'pId':pId,
      'postImage':postImage,
      'text':text,
      'dataTime':dataTime,

    };
  }
}