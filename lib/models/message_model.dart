class MessageModel{
  String? sender ;
  String? receiver;
  String? text;
  String? dateTime;



  MessageModel({
    required this.sender,
    required this.receiver,
    required this.text,
    required this.dateTime,
  });

  MessageModel.fromJson(Map<String , dynamic>? json){
    sender = json?['sender'];
    receiver = json?['receiver'];
    text = json?['text'];
    dateTime = json?['dateTime'];




  }

  Map<String , dynamic> toMap(){
    return{
      'sender':sender,
      'receiver':receiver,
      'text':text,
      'dateTime':dateTime,

    };
  }
}