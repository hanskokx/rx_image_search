import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({
    Key? key,
  }) : super(key: key);

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  late RiveAnimationController _controller;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 350,
        width: 350,
        child: RiveAnimation.asset(
          'assets/animations/lumberjack_squats.riv',
          animations: const ['Idle', 'Squat'],
          controllers: [_controller],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = OneShotAnimation(
      'Squat',
    );
  }
}
