import 'package:get/get.dart';

enum NotesView { grid, list }

class MainScreenController extends GetxController {
  RxBool isFabOpen = false.obs;
  Rx<NotesView> view = NotesView.grid.obs;

  void toggleFab() {
    isFabOpen.value = !isFabOpen.value;
  }

  void toggleView() {
    view.value = view.value == NotesView.grid ? NotesView.list : NotesView.grid;
  }

  void closeFab() {
    isFabOpen.value = false;
  }
}
