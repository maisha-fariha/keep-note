import 'package:get/get.dart';

enum NotesView { grid, list }

class MainScreenController extends GetxController {
  RxBool isFabOpen = false.obs;
  Rx<NotesView> view = NotesView.grid.obs;

  RxBool selectionMode = false.obs;
  RxSet<String> selectedIds = <String>{}.obs;

  void toggleFab() {
    isFabOpen.value = !isFabOpen.value;
  }

  void toggleView() {
    view.value = view.value == NotesView.grid ? NotesView.list : NotesView.grid;
  }

  void closeFab() {
    isFabOpen.value = false;
  }

  void onLongPressed(String id) {
    selectionMode.value = true;
    selectedIds.add(id);
  }

  void onTap(String id) {
    if (!selectionMode.value) return;

    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
      if(selectedIds.isEmpty) {
        selectionMode.value = false;
      }
    } else {
      selectedIds.add(id);
    }
  }

  void clearSelection() {
    selectionMode.value = false;
    selectedIds.clear();
  }
}
