import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {

  Color get background => Color(0xffF2F5F8);

  Color get primary => Color(0xff5775FF);

  Color get error => Color(0xFFE53935);

  Color get secondary => Color(0xffBFBFD5);

  Color get white => Color(0xffFFFFFF);

  Color get grayLight => Color(0xffC7C7CC);

  Color get textBlackLight => Color(0xff464850);

  Color get textBlackDark => Color(0xff373D47);

  Color get textGrayWithOpacity => Color(0xff373D47).withOpacity(0.6);



  TextStyle _ubantu = TextStyle(fontFamily: 'Ubantu');

  TextStyle get ubantu20BlackLightNormal => _ubantu.copyWith(
        fontSize: 20.0,
        color: textBlackLight,
        height: 23.0 / 20.0,
        fontWeight: FontWeight.normal,
      );

  TextStyle get ubantu13GrayWithOpacityW500 => _ubantu.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 13.0,
        height: 18.0 / 13.0,
        letterSpacing: 1.38,
        color: textGrayWithOpacity,
      );

  TextStyle get ubantu17BlackDarkW500 => _ubantu.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 17.0,
        height: 22.0 / 17.0,
        letterSpacing: 1.29,
        color: textBlackDark,
      );

  TextStyle get ubantu17PrimaryW500 => _ubantu.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 17.0,
        height: 22.0 / 17.0,
        letterSpacing: 1.29,
        color: primary,
      );

  TextStyle get ubantu17BlackDarkNormal => _ubantu.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 17.0,
        height: 22.0 / 17.0,
        letterSpacing: 1.29,
        color: textBlackDark,
      );

  TextStyle get ubantu14WhiteNormal => _ubantu.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 14.48,
        height: 17.0 / 14.48,
        color: white,
      );
}

class Thm extends InheritedWidget {
  final AppTheme data;

  const Thm({
    Key key,
    @required this.data,
    @required Widget child,
  })  : assert(child != null),
        assert(data != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(Thm oldWidget) => data != oldWidget.data;

  static AppTheme of(BuildContext context) {
    // ignore: omit_local_variable_types
    final Thm theme = context.dependOnInheritedWidgetOfExactType();
    return theme?.data ?? AppTheme();
  }
}
