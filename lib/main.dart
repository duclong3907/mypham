import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mypham_shop/routes/routes.dart';

import 'config/binding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411, 914),
      minTextAdapt: true,
      builder:
          (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cửa hàng mỹ phẩm',
        initialBinding: DetailBinding(),
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
      ),
    );
  }
}
