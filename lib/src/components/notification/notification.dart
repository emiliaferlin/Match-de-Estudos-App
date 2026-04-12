import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class NotificationMatchEstudo {
  static sucess(context, {required String? message}) {
    if (message == null) {
      throw ("Preencha pelo menos uma menssagem");
    }
    AnimatedSnackBar(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.check_circle_outline_outlined,
                  size: 36.0,
                  color: Colors.green,
                ),
              ),
              Expanded(
                child: Text(message, style: TextStyle(color: Colors.black)),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  AnimatedSnackBar.removeAll();
                },
              ),
            ],
          ),
        );
      },
      duration: Duration(milliseconds: message.length * 300),
      mobilePositionSettings: MobilePositionSettings(
        topOnAppearance: 60.0,
        left: 8.0,
        right: 8.0,
      ),
      mobileSnackBarPosition: MobileSnackBarPosition.top,
    ).show(context);
  }

  static warning(context, {required message}) {
    if (message == null) {
      throw ("Preencha pelo menos uma menssagem");
    }
    AnimatedSnackBar(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.warning_rounded,
                  size: 36.0,
                  color: Colors.orangeAccent,
                ),
              ),
              Expanded(
                child: Text(message, style: TextStyle(color: Colors.black)),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  AnimatedSnackBar.removeAll();
                },
              ),
            ],
          ),
        );
      },
      duration: Duration(milliseconds: message.length * 300),
      mobilePositionSettings: MobilePositionSettings(
        topOnAppearance: 60.0,
        left: 8.0,
        right: 8.0,
      ),
      mobileSnackBarPosition: MobileSnackBarPosition.top,
    ).show(context);
  }

  static error(context, {required message}) {
    if (message == null) {
      throw ("Preencha pelo menos uma menssagem");
    }
    AnimatedSnackBar(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.error_outline_outlined,
                  color: Colors.red,
                  size: 36.0,
                ),
              ),
              Expanded(
                child: Text(message, style: TextStyle(color: Colors.black)),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  AnimatedSnackBar.removeAll();
                },
              ),
            ],
          ),
        );
      },
      duration: Duration(milliseconds: message.length * 300),
      mobilePositionSettings: MobilePositionSettings(
        topOnAppearance: 60.0,
        left: 8.0,
        right: 8.0,
      ),
      mobileSnackBarPosition: MobileSnackBarPosition.top,
    ).show(context);
  }
}
