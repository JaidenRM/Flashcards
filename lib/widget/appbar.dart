import 'package:flashcards/constants.dart';
import 'package:flutter/material.dart';

AppBar getAppBar(String title) => AppBar(
  title: Text(
    title, 
    style: TextStyle(
      color: SECONDARY_COL
    )
  )
);