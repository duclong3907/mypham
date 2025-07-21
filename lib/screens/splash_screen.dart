import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../utils/function_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _videoController;

  bool showLottie = true;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      setState(() {
        showLottie = false;
      });
      _videoController = VideoPlayerController.asset("assets/videos/video_intro.mp4");
      await _videoController.initialize();
      setState(() {});
      _videoController.play();
      _videoController.addListener(() {
        if (_videoController.value.position >= _videoController.value.duration &&
            !_navigated &&
            _videoController.value.isInitialized &&
            mounted) {
          _navigated = true;
          _navigateToNextScreen();
        }
      });
    });
  }

  void _navigateToNextScreen() {
    Get.toNamed('/home');
  }

  @override
  void dispose() {
    if (!_navigated && _videoController.value.isInitialized) {
      _videoController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      showLottie
          ? loadingWidget(200, 200)
          : (_videoController.value.isInitialized ? VideoPlayer(_videoController) : loadingWidget(200, 200)),
    );
  }
}