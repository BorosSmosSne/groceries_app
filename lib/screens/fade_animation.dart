import 'package:flutter/material.dart';

// --- Screen 1: Home Screen ---
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  // Custom route combining Slide and Fade
  Route _createSlideFadeRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const DetailScreen(),
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // 1. Slide Animation: Starts offscreen below and moves to center
        final slideTween = Tween<Offset>(
          begin: const Offset(0.0, 0.3), // 30% below screen
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic));

        // 2. Fade Animation: 0.0 (transparent) to 1.0 (fully visible)
        final fadeTween = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn));

        return SlideTransition(
          position: animation.drive(slideTween),
          child: FadeTransition(
            opacity: animation.drive(fadeTween),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(_createSlideFadeRoute());
          },
          child: const Text('Open Detail Screen'),
        ),
      ),
    );
  }
}

// --- Screen 2: Destination Screen ---
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(title: const Text('Detail Screen')),
      body: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_outline, color: Colors.green, size: 64),
                const SizedBox(height: 16),
                const Text(
                  'Page Transition Loaded',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}