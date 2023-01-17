class Skill {
  final String name;
  final String description;
  double rating;

  Skill({
    required this.name,
    required this.description,
    this.rating = 0,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'],
      description: json['description'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'rating': rating,
    };
  }
}
