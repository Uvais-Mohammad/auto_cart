import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext{
  void push(Widget widget){
    Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  void pushReplacement(Widget widget){
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  void pushAndRemoveUntil(Widget widget){
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );
  }

  void pop(){
    Navigator.pop(this);
  }
}