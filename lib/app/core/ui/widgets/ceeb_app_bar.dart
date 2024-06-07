import 'package:flutter/material.dart';

class CeebAppBar extends AppBar {
  CeebAppBar({
    super.key,
    String? title,
    double elevation = 2,
  }) : super(
            elevation: elevation,
            centerTitle: true,
            title: Text(
              title ?? 'CEEB',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.blue,
            iconTheme: const IconThemeData(
              color: Colors.white,
              size: 30,
            ));
}
