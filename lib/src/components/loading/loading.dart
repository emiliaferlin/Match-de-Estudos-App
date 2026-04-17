import 'package:flutter/material.dart';
import 'package:flutter_progress_loading/flutter_progress_loading.dart';
import 'package:match_estudos_app/src/core/shared/constantes.dart';

class LoadingPlant {
  static initLoading(BuildContext context) {
    ProgressLoading.instance
      ..indicatorType = ProgressLoadingIndicatorType.ring
      ..loadingStyle = ProgressLoadingStyle.light
      ..indicatorSize = 45.0
      ..backgroundColor = Colors.black.withValues(alpha: 0.8)
      ..radius = 4.0
      ..progressColor = primaryColor
      ..textColor = Colors.black
      ..maskType = ProgressLoadingMaskType.black
      ..maskColor = Colors.black.withValues(alpha: 0.9)
      ..userInteractions = false
      ..dismissOnTap = false;
    return ProgressLoading.init();
  }

  static Future requestLoader(
    bool show, {
    String label = 'Carregando',
    bool dismissOnTap = false,
  }) async {
    if (show) {
      await ProgressLoading.dismiss();
      await ProgressLoading.show(status: label, dismissOnTap: dismissOnTap);
    } else {
      await ProgressLoading.dismiss();
    }
  }

  static buildCircularLoader(context, {size = 50.0}) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size,
            width: size,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
