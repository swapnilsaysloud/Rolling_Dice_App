import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  // Stateful widget because data will be present
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int leftDice = 1;
  int rightDice = 1;
  late AnimationController _controller; // Global declaration
  late CurvedAnimation animation;
  @override
  void initState() { // this is carried only once when build is created 
    super.initState();
    animate();
  }

  @override // Controller needs to e disposed once it is created
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  animate() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    animation.addListener(() {
      setState(() {});
      //print(_controller.value);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          // Set state loads the build again whenever this function is called
          leftDice = Random().nextInt(6) + 1;
          rightDice = Random().nextInt(6) + 1; // Included math package for this
        });
        // print('completed');
        _controller.reverse();
      }
    });
  }

  void roll() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diceee'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
              Expanded(
                child: GestureDetector(
                  onDoubleTap: roll,
                  child: Padding(
                    // to keep both the images a bit distant
                    padding: EdgeInsets.all(15),
                    child: Image(
                        height: 200 - (animation.value) * 100,
                        image:
                            AssetImage('assets/images/dice-png-$leftDice.png')),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onDoubleTap: roll,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Image(
                        height: 200 - (animation.value) * 100,
                        image: AssetImage(
                            'assets/images/dice-png-$rightDice.png')),
                  ),
                ),
              ),
            ]),
            OutlinedButton(
                onPressed: roll,
                child: Text(
                  'ROLL',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )) // we can add different styles to the button from here , "onpressed : roll" gives the response when clicked, don't put "roll()" as then it will be called even if button is not pressed.
          ],
        ),
      ),
    );
  }
}
