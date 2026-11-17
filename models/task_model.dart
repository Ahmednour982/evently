class TaskModel {
  final String id;
  final String title;
  final String type;
  final String? description;
  final String? location;
  final String dateTime;
  final bool isCompleted;
  final String createdAt;
  final String updatedAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.type,
    this.description,
    this.location,
    required this.dateTime,
    this.isCompleted = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'description': description,
      'location': location,
      'dateTime': dateTime,
      'isCompleted': isCompleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      type: map['type'] as String,
      description: map['description'] as String?,
      location: map['location'] as String?,
      dateTime: (map['dateTime'] as String),
      isCompleted: map['isCompleted'] as bool? ?? false,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }
}