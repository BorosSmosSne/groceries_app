import 'package:flutter/material.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  double _step = 20.0;
  double _positionX = 16.0;
  double _positionY = 20.0;
  double _size = 60.0;

  void _moveForward(double screenWidth) {
    setState(() {
      // Boundary check: ensures the pet + step never exceeds the right edge
      if (_positionX + _size + 20.0 <= screenWidth - 16) {
        _positionX += _step;
        _size += 10.0; // scale up
      }
    });
  }

  void _moveBackward() {
    setState(() {
      if (_positionX - _step >= 16.0) {
        _positionX -= _step;
        _size -= 10.0;
      } else {
        _positionX = 16.0;
        _size = 60.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: _positionX,
              top: _positionY,
              child: AnimatedContainer(
                height: _size,
                width: _size,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: Alignment.center,
                child: Icon(Icons.pets, size: _size * 0.8, color: Colors.blue),
                // decoration: const BoxDecoration(
                //   color: Colors.red,
                //   shape: BoxShape.circle,
                // ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       _positionX += 20;
                  //       _size += 10;
                  //       setState(() {});
                  //     });
                  //   },
                  //   child: const Text("Click Me"),
                  // ),
                  ElevatedButton(
                    onPressed: _moveBackward,
                    child: const Text("Move Backward"),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => _moveForward(screenSize.width),
                    child: const Text("Move Forward"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
