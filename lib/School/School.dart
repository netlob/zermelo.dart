class School {
  final int id;
  final String name;
  School({required this.id, required this.name});

  factory School.fromJson(Map<String, dynamic> json) {
    return School(id: json['id'], name: json['name']);
  }
}
