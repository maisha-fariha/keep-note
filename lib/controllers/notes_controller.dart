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

  List<NotesModel> get activeNotes =>
      notes.where((n) => !n.isDeleted).toList();

  List<NotesModel> get deletedNotes =>
      notes.where((n) => n.isDeleted).toList();


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

  void deleteNotes(Set<String> ids) {
    for (int i = 0; i < notes.length; i++) {
      if (ids.contains(notes[i].id)) {
        notes[i] = notes[i].copyWith(isDeleted: true);
      }
    }
    saveNotes();
  }

  void restoreNotes(Set<String> ids) {
    for (int i = 0; i < notes.length; i++) {
      if (ids.contains(notes[i].id)) {
        notes[i] = notes[i].copyWith(isDeleted: false);
      }
    }
    saveNotes();
  }

  void emptyBin() {
    notes.removeWhere((note) => note.isDeleted);
    saveNotes();
    notes.refresh();
  }
}
