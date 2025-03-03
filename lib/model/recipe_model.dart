class RecipeModel {
  final String name;
  final String description;
  final String time;
  final String steps;
  final String image;
  final Map<String, dynamic> ingredients;

  RecipeModel({
    required this.ingredients,
    required this.name,
    required this.description,
    required this.time,
    required this.steps,
    required this.image,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
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
      'title': name,
      'description': description,
      'time': time,
      'steps': steps,
      'image': image,
      'ing': ingredients,
    };
  }
}