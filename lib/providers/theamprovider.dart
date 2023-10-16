import 'package:flutter/cupertino.dart';
import '../model/ttheammodel.dart';

class Themeprovider extends ChangeNotifier {
  Thememodel theme = Thememodel(isdark: false);
  void changetheme() {
    theme.isdark = !theme.isdark;
    notifyListeners();
  }
}
