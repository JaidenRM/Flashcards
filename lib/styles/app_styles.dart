import 'package:flutter/material.dart';
import '../constants.dart';

abstract class AppText {
  static const TextStyle MAX_TEXT = TextStyle(fontSize: 690, color: PRIMARY_COL);
  static const TextStyle TOOLTIP_TEXT = TextStyle(
    fontSize: 80,
    color: Colors.white,
    backgroundColor: Colors.black
  );
}

abstract class AppDeco {
  static final BoxDecoration BOX_BORDER_SHADOW = 
    BoxDecoration(
      boxShadow: const [ BoxShadow(blurRadius: 10) ],
      border: Border.all(color: TERTIARY_COL, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(18)),
      color: SECONDARY_COL
    );
  
  static final BoxDecoration BLACK_BOX = 
    BoxDecoration (
      borderRadius: BorderRadius.all(Radius.circular(18)),
      color: Colors.black
    );
}