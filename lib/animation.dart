import 'dart:math';

import 'package:flutter/material.dart';

class ChainingAnimation extends StatefulWidget {
  @override
  _ChainingAnimationState createState() => _ChainingAnimationState();
}

class _ChainingAnimationState extends State<ChainingAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> opacityAnimation;
  Animation<double> rotationAnimation;
  Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.0, 0.3, curve: Curves.fastOutSlowIn),
    ));

    rotationAnimation = Tween<double>(
      begin: 0.0,
      end: pi * 4,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.3, 0.6, curve: Curves.ease),
    ));

    sizeAnimation = Tween<double>(
      begin: 70,
      end: 120,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn),
    ));

    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chainig Multiple Animation")),
      body: Center(
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Container(
              transform: Matrix4.identity()..rotateZ(rotationAnimation.value),
              child: Opacity(
                opacity: opacityAnimation.value,
                child: Container(
                  color: Colors.blue,
                  height: sizeAnimation.value,
                  width: sizeAnimation.value,
                ),
              ),
            );
          },
          /*  child: Container(
            color: Colors.red,
            height: animation.value,
            width: animation.value,
          ), */
        ),
      ),
    );
  }
}
