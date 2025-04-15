import 'package:flutter/cupertino.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/users_model.dart';

class UserProvider extends ChangeNotifier {
  UsersModel? _currentUser;
  UsersModel? get currentUser => _currentUser;
  DBMatser db = DBMatser();
  //
  Future<void> initialize() async {
    UsersModel? usersModel = await db.getLoggedInUser();
    if (usersModel != null) {
      _currentUser = usersModel;
    }
    notifyListeners();
  }

  Future<UsersModel?> getCurrentUserID() async {
    if (_currentUser != null) {
      return _currentUser;
    } else {
      UsersModel? usersModel = await db.getLoggedInUser();
      return usersModel;
    }
  }

  void setUser(UsersModel usersModel) {
    _currentUser = usersModel;
    notifyListeners();
  }

  void clearUser() {
    _currentUser = null;
    notifyListeners();
  }

  String get isAdmin => _currentUser?.role ?? '0';
}
