class EventModel {
  final String id;
  final String title;
  final String type;
  final String? description;
  final String? location;
  final String dateTime;
  final bool isFavorite;
  final String createdAt;
  final String updatedAt;

  EventModel({
    required this.id,
    required this.title,
    required this.type,
    this.description,
    this.location,
    required this.dateTime,
    this.isFavorite = false,
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
      'isFavorite': isFavorite,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] as String,
      title: map['title'] as String,
      type: map['type'] as String,
      description: map['description'] as String?,
      location: map['location'] as String?,
      dateTime: map['dateTime'] as String,
      isFavorite: map['isFavorite'] as bool? ?? false,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }
}

class ContactModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? company;
  final String? jobTitle;
  final bool isFavorite;
  final String createdAt;
  final String updatedAt;

  ContactModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.company,
    this.jobTitle,
    this.isFavorite = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'company': company,
      'jobTitle': jobTitle,
      'isFavorite': isFavorite,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String?,
      address: map['address'] as String?,
      company: map['company'] as String?,
      jobTitle: map['jobTitle'] as String?,
      isFavorite: map['isFavorite'] as bool? ?? false,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }
}

class TaskModel {
  final String id;
  final String title;
  final String type;
  final String? description;
  final String dateTime;
  final String priority; // low, medium, high
  final bool isCompleted;
  final bool isFavorite;
  final String createdAt;
  final String updatedAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.type,
    this.description,
    required this.dateTime,
    this.priority = 'medium',
    this.isCompleted = false,
    this.isFavorite = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'description': description,
      'dateTime': dateTime,
      'priority': priority,
      'isCompleted': isCompleted,
      'isFavorite': isFavorite,
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
      dateTime: map['dateTime'] as String,
      priority: map['priority'] as String? ?? 'medium',
      isCompleted: map['isCompleted'] as bool? ?? false,
      isFavorite: map['isFavorite'] as bool? ?? false,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }
}