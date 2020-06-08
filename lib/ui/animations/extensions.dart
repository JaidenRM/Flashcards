import 'dart:math';

import 'package:flutter/material.dart';

class FlipTransition extends AnimatedWidget {
  final Widget child;
  Animation<double> get rotate => listenable as Animation<double>;

  const FlipTransition({
    this.child,
    @required Animation<double> anim,
    Key key
  }) : assert(anim != null), 
      super(key: key, listenable: anim);
  
  @override
  Widget build(BuildContext context) {
    final xRotate = rotate.value;

    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) //These are magic numbers, just use them :)
        ..rotateX(xRotate * 2 * pi),
      child: child);
  }

}