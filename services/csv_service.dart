import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../models/event_model.dart';
import 'storage_service.dart';

class CsvService {
  static Future<bool> exportEventsToCSV() async {
    try {
      final events = StorageService.getAllEvents();
      if (events.isEmpty) return false;

      List<List<dynamic>> csvData = [
        ['ID', 'Title', 'Type', 'Description', 'Location', 'DateTime', 'IsFavorite']
      ];

      for (var event in events) {
        csvData.add([
          event.id,
          event.title,
          event.type,
          event.description ?? '',
          event.location ?? '',
          event.dateTime,
          event.isFavorite ? 'Yes' : 'No',
        ]);
      }

      String csv = const ListToCsvConverter().convert(csvData);

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/route_contacts_events.csv';
      final file = File(filePath);
      await file.writeAsString(csv);

      return true;
    } catch (e) {
      print('Export error: $e');
      return false;
    }
  }

  static Future<bool> importEventsFromCSV() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (result == null || result.files.single.path == null) {
        return false;
      }

      final filePath = result.files.single.path!;
      final file = File(filePath);
      final csvString = await file.readAsString();

      List<List<dynamic>> rows = const CsvToListConverter().convert(csvString);
      if (rows.isEmpty) return false;

      for (int i = 1; i < rows.length; i++) {
        final row = rows[i];
        if (row.length < 6) continue;

        final event = EventModel(
          id: row[0].toString(),
          title: row[1].toString(),
          type: row[2].toString(),
          description: row[3].toString().isEmpty ? null : row[3].toString(),
          location: row[4].toString().isEmpty ? null : row[4].toString(),
          dateTime: row[5].toString(),
          isFavorite: row.length > 6 && row[6].toString().toLowerCase() == 'yes',
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        );

        await StorageService.addEvent(event);
      }

      return true;
    } catch (e) {
      print('Import error: $e');
      return false;
    }
  }
}