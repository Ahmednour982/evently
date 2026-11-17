import 'package:hive/hive.dart';
import '../models/event_model.dart';
import '../core/constants/app_constants.dart';

class StorageService {
  static late Box _eventsBox;
  static late Box _contactsBox;
  static late Box _tasksBox;
  static late Box _settingsBox;

  static Future<void> init() async {
    _eventsBox = await Hive.openBox(AppConstants.eventsBox);
    _contactsBox = await Hive.openBox(AppConstants.contactsBox);
    _tasksBox = await Hive.openBox(AppConstants.tasksBox);
    _settingsBox = await Hive.openBox(AppConstants.settingsBox);
  }

  // ========== Events ==========
  static Future<void> addEvent(EventModel event) async {
    await _eventsBox.put(event.id, event.toMap());
  }

  static Future<void> updateEvent(EventModel event) async {
    await _eventsBox.put(event.id, event.toMap());
  }

  static List<EventModel> getAllEvents() {
    return _eventsBox.values
        .map((map) => EventModel.fromMap(Map<String, dynamic>.from(map as Map)))
        .toList();
  }

  static EventModel? getEvent(String id) {
    final map = _eventsBox.get(id);
    if (map == null) return null;
    return EventModel.fromMap(Map<String, dynamic>.from(map as Map));
  }

  static Future<void> deleteEvent(String id) async {
    await _eventsBox.delete(id);
  }

  static List<EventModel> getFavoriteEvents() {
    return getAllEvents().where((e) => e.isFavorite).toList();
  }

  // ========== Contacts ==========
  static Future<void> addContact(ContactModel contact) async {
    await _contactsBox.put(contact.id, contact.toMap());
  }

  static Future<void> updateContact(ContactModel contact) async {
    await _contactsBox.put(contact.id, contact.toMap());
  }

  static List<ContactModel> getAllContacts() {
    return _contactsBox.values
        .map((map) => ContactModel.fromMap(Map<String, dynamic>.from(map as Map)))
        .toList();
  }

  static ContactModel? getContact(String id) {
    final map = _contactsBox.get(id);
    if (map == null) return null;
    return ContactModel.fromMap(Map<String, dynamic>.from(map as Map));
  }

  static Future<void> deleteContact(String id) async {
    await _contactsBox.delete(id);
  }

  static List<ContactModel> getFavoriteContacts() {
    return getAllContacts().where((c) => c.isFavorite).toList();
  }

  // ========== Tasks ==========
  static Future<void> addTask(TaskModel task) async {
    await _tasksBox.put(task.id, task.toMap());
  }

  static Future<void> updateTask(TaskModel task) async {
    await _tasksBox.put(task.id, task.toMap());
  }

  static List<TaskModel> getAllTasks() {
    return _tasksBox.values
        .map((map) => TaskModel.fromMap(Map<String, dynamic>.from(map as Map)))
        .toList();
  }

  static TaskModel? getTask(String id) {
    final map = _tasksBox.get(id);
    if (map == null) return null;
    return TaskModel.fromMap(Map<String, dynamic>.from(map as Map));
  }

  static Future<void> deleteTask(String id) async {
    await _tasksBox.delete(id);
  }

  static List<TaskModel> getFavoriteTasks() {
    return getAllTasks().where((t) => t.isFavorite).toList();
  }

  static List<TaskModel> getPendingTasks() {
    return getAllTasks().where((t) => !t.isCompleted).toList();
  }
}