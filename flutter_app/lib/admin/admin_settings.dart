
import 'package:flutter/foundation.dart';

class AdminSettings extends ChangeNotifier {
  bool _darkMode = true;
  bool _compactTables = false;
  bool _emailNotifications = true;
  bool _autoApproveArtists = false;

  bool get darkMode => _darkMode;
  bool get compactTables => _compactTables;
  bool get emailNotifications => _emailNotifications;
  bool get autoApproveArtists => _autoApproveArtists;

  void setDarkMode(bool v) {
    _darkMode = v;
    notifyListeners();
  }

  void setCompactTables(bool v) {
    _compactTables = v;
    notifyListeners();
  }

  void setEmailNotifications(bool v) {
    _emailNotifications = v;
    notifyListeners();
  }

  void setAutoApproveArtists(bool v) {
    _autoApproveArtists = v;
    notifyListeners();
  }
}
