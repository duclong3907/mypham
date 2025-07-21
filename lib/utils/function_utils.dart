import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

Widget loadingWidget(double width, double height) {
  return Center(child: Lottie.asset('assets/lottie/loading.json', width: width.w, height: height.h));
}