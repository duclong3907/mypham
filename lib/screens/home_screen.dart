import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypham_shop/screens/order_tab.dart';
import 'package:mypham_shop/screens/product_tab.dart';
import '../controllers/home_controller.dart';
import 'home_tab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.put(HomeController());
  final List<Widget> _pages = [HomeTab(), ProductTab(), OrderTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[homeController.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: homeController.currentIndex.value,
          selectedItemColor: Color(0xFF8D6E63),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => homeController.changeTab(index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
            BottomNavigationBarItem(icon: Icon(Icons.pest_control_rodent), label: 'Sản phẩm'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Đơn hàng'),
          ],
        ),
      ),
    );
  }
}
