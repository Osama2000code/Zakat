import 'package:flutter/cupertino.dart';
import 'package:zakat_app/DataBase/Models/users_model.dart';

class UserProvider extends ChangeNotifier {
  UsersModel? _currentUser;
  UsersModel? get currentUser => _currentUser;
  // 
  void setUser(UsersModel usersModel) {
    _currentUser = usersModel;
    notifyListeners();
  }

  void clearUser() {
    _currentUser = null;
    notifyListeners();
  }

  String get isAdmin => _currentUser?.role ?? 'USER';
}
