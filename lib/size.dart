import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late double fontsize;
  static late TextStyle normalfont;
  static late TextStyle smallnormalfont;
  static late TextStyle smallnormalfont2;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    fontsize = screenHeight * screenWidth * 0.01 * 0.01 * 0.1;
    // fontsize= blockSizeVertical*2;
    print(fontsize);
    normalfont = TextStyle(
      fontSize: fontsize,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );
    smallnormalfont = TextStyle(
      fontSize: fontsize / 2,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );
    smallnormalfont2 = TextStyle(
      fontSize: fontsize * 0.4,
      color: Colors.white,
    );
  }
}
