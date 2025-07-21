import 'package:get/get.dart';
import 'package:mypham_shop/controllers/home_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}