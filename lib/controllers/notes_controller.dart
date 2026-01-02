import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keep_note/models/notes_model.dart';

class NotesController extends GetxController {
  final RxList<NotesModel> notes = <NotesModel>[].obs;
  final GetStorage _box = GetStorage();

  static String _storageKey = 'notes';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadNotes();
  }

  void loadNotes() {
    final storedNotes = _box.read<List>(_storageKey);
    print(GetStorage().read('notes'));

    if (storedNotes != null && storedNotes.isNotEmpty) {
      notes.assignAll(
        storedNotes.map(
          (e) => NotesModel.fromMap(Map<String, dynamic>.from(e)),
        ),
      );
    }
  }

  void addNotes(NotesModel note) {
    notes.add(note);
    saveNotes();
  }

  void updateNote(NotesModel note) {
    final index = notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      notes[index] = note;
      saveNotes();
    }
  }

  void saveNotes() {
    _box.write(_storageKey, notes.map((e) => e.toMap()).toList());
  }
}
