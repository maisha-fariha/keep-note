import 'package:get/get.dart';

class MainScreenController extends GetxController{
  RxBool isFabOpen = false.obs;

  void toggleFab() {
    isFabOpen.value = ! isFabOpen.value;
  }

  void closeFab() {
    isFabOpen.value = false;
  }
}