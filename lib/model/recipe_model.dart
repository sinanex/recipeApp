class RecipeModel {
  final String name;
  final String description;
  final String time;
  final String steps;
  final String image;
  final Map<String, dynamic> ingredients;
  final String username;
  final String catogary;
  final String? id;

  RecipeModel({
     this.id,
    required this.catogary,
    required this.username,
    required this.ingredients,
    required this.name,
    required this.description,
    required this.time,
    required this.steps,
    required this.image,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json,String id) {
    return RecipeModel(
      id: id,
      catogary: json['catogary']??'',
      username: json['username']??'',
      ingredients: Map<String, dynamic>.from(json["ing"] ?? {}),
      image: json['image'] ?? '',
      steps: json['steps'] ?? '',
      time: json['time'] ?? '',
      name: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'catogary':catogary,
      'username':username,
      'title': name,
      'description': description,
      'time': time,
      'steps': steps,
      'image': image,
      'ing': ingredients,
    };
  }
}