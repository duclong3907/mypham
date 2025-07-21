import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var currentIndexAdmin = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }

  void changeTabAdmin(int index) {
    currentIndexAdmin.value = index;
  }

  void resetTab() {
    currentIndex.value = 0;
    currentIndexAdmin.value = 0;
  }

}