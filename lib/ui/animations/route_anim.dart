import 'package:flutter/material.dart';

Route createRouteAnim(Widget transitionTo) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => transitionTo,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1.0, -1.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.ease));
      var offsetAnim = animation.drive(tween);

      return SlideTransition(
        position: offsetAnim,
        child: child,
      );
    }
  );
}