import 'package:flutter/material.dart';

class TextStyleMatchEstudo {
  TextStyleMatchEstudo._();

  static const Color _defaultColor = Color(0xFF2E2E2E);

  static const String _fontFamily = 'Lato';

  static final _baseBodyTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: _defaultColor,
    fontFamily: _fontFamily,
  );

  static final _baseTitleTextStyle = TextStyle(
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.normal,
    color: _defaultColor,
    fontFamily: _fontFamily,
  );

  /// [bodyXXS]
  /// - FontSize 10
  /// - FontWeight 400
  static TextStyle bodyXXS({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) => _baseBodyTextStyle.copyWith(
    fontSize: 10,
    inherit: inherit,
    color: color,
    backgroundColor: backgroundColor,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
    debugLabel: debugLabel,
    overflow: overflow,
  );

  /// [bodyXS]
  /// - FontSize 12
  /// - FontWeight 400
  static TextStyle bodyXS({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    return _baseBodyTextStyle.copyWith(
      fontSize: 12,
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      overflow: overflow,
    );
  }

  /// [bodySM]
  /// - FontSize 14
  /// - FontWeight 400
  static TextStyle bodySM({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    return _baseBodyTextStyle.copyWith(
      fontSize: 14,
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      overflow: overflow,
    );
  }

  /// [bodyMD]
  /// - FontSize 16
  /// - FontWeight 400
  static TextStyle bodyMD({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    return _baseBodyTextStyle.copyWith(
      fontSize: 16,
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      overflow: overflow,
    );
  }

  /// [bodyLG]
  /// - FontSize 18
  /// - FontWeight 400
  static TextStyle bodyLG({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    return _baseBodyTextStyle.copyWith(
      fontSize: 18,
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      overflow: overflow,
    );
  }

  /// [bodyXL]
  /// - FontSize 20
  /// - FontWeight 400
  static TextStyle bodyXL({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    return _baseBodyTextStyle.copyWith(
      fontSize: 20,
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      overflow: overflow,
    );
  }

  /// [bodyXXL]
  /// - FontSize 22
  /// - FontWeight 400
  static TextStyle bodyXXL({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    return _baseBodyTextStyle.copyWith(
      fontSize: 22,
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      overflow: overflow,
    );
  }

  /// [bodyXXXL]
  /// - FontSize 24
  /// - FontWeight 400
  static TextStyle bodyXXXL({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    return _baseBodyTextStyle.copyWith(
      fontSize: 24,
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      overflow: overflow,
    );
  }

  /// [titleXXS]
  /// - FontSize 12
  /// - FontWeight 900
  static TextStyle titleXXS({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    return _baseTitleTextStyle.copyWith(
      fontSize: 12,
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      overflow: overflow,
    );
  }

  /// [titleXS]
  /// - FontSize 14
  /// - FontWeight 900
  static TextStyle titleXS({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    return _baseTitleTextStyle.copyWith(
      fontSize: 14,
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      overflow: overflow,
    );
  }

  /// [titleSM]
  /// - FontSize 16
  /// - FontWeight 900
  static TextStyle titleSM({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    return _baseTitleTextStyle.copyWith(
      fontSize: 16,
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      overflow: overflow,
    );
  }

  /// [titleMD]
  /// - FontSize 18
  /// - FontWeight 900
  static TextStyle titleMD({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    return _baseTitleTextStyle.copyWith(
      fontSize: 18,
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      overflow: overflow,
    );
  }

  /// [titleMMD]
  /// - FontSize 24
  /// - FontWeight 900
  static TextStyle titleMMD({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    return _baseTitleTextStyle.copyWith(
      fontSize: 24,
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      overflow: overflow,
    );
  }

  /// [titleXXL]
  /// - FontSize 32
  /// - FontWeight 900
  static TextStyle titleLG({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    return _baseTitleTextStyle.copyWith(
      fontSize: 32,
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      overflow: overflow,
    );
  }

  /// [titleXL]
  /// - FontSize 38
  /// - FontWeight 900
  static TextStyle titleXL({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    return _baseTitleTextStyle.copyWith(
      fontSize: 38,
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      overflow: overflow,
    );
  }

  /// [titleXXL]
  /// - FontSize 48
  /// - FontWeight 900
  static TextStyle titleXXL({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) {
    return _baseTitleTextStyle.copyWith(
      fontSize: 48,
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      overflow: overflow,
    );
  }
}
