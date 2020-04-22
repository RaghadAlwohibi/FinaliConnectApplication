import 'package:flutter/widgets.dart';

class MyIcons {
  MyIcons._();

  static const _kFontFam = 'MyFlutterApp';

  static const IconData heart_empty =
      const IconData(0xe800, fontFamily: _kFontFam);
  static const IconData heart = const IconData(0xe801, fontFamily: _kFontFam);
  static const IconData comment = const IconData(0xe802, fontFamily: _kFontFam);
  static const IconData comment_empty =
      const IconData(0xf0e5, fontFamily: _kFontFam);
}
