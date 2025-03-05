class Comments {
  final String name;
  final String image;
  final String comment;
  final String? recipeid;

  Comments({
     this.recipeid,
    required this.comment,
    required this.image,
    required this.name
  });

  factory Comments.fromJson(Map<String,dynamic>json){
    return Comments(comment: json['comment'], image: json['image'], name: json['name'],recipeid: json['id']);
  }

  Map<String,dynamic> toJson(){
     return {
      'id':recipeid,
      'name':name,
      'image':image,
      'comment':comment
     };
  }
}