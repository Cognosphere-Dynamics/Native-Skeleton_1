import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  Timer? _slideTimer;
  int _currentPage = 0;
  final List<String> _images = [
    'assets/t1.jpg',
    'assets/t2.jpg',
    'assets/t3.jpg',
    'assets/t4.jpg',
    'assets/t5.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startSlideshow();
  }

  void _startSlideshow() {
    _slideTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _slideTimer?.cancel();
        _navigateToMainScreen();
      }
    });
  }

  void _navigateToMainScreen() {
    Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  void dispose() {
    _slideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Hero(
                tag: 'splash_image_$index',
                child: Image.asset(
                  _images[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Theme.of(context).primaryColor,
                    child: const Icon(Icons.image_not_supported, size: 50),
                  ),
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          Center(
            child: Lottie.asset(
              'assets/animation_1.json',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
              const CircularProgressIndicator(),
            ),
          ),

        ],
      ),
    );
  }
}