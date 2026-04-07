import 'package:get/get.dart';

class NotesController extends GetxController {
  final notesList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void addNote(DateTime time, String content) {
    notesList.add({
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'time': time,
      'content': content,
    });
  }

  void editNote(int index, DateTime newTime, String newContent) {
    notesList[index] = {
      'id': notesList[index]['id'],
      'time': newTime,
      'content': newContent,
    };
    notesList.refresh();
  }

  void deleteNote(int index) {
    notesList.removeAt(index);
  }

  Future<void> fetchNotes() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
