import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/users_model.dart';

class UserProvider extends ChangeNotifier {
  UsersModel? _currentUser;
  UsersModel? get currentUser => _currentUser;
  DBMatser db = DBMatser();
  //
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final userID = prefs.getInt("LoggedInUser");
    if (userID != null) {
      _currentUser = await db.getUser(userID);
      notifyListeners();
    }
  }

  Future<UsersModel?> getCurrentUserID() async {
    if (_currentUser != null) {
      return _currentUser;
    } else {
      UsersModel? usersModel = await db.getLoggedInUser();
      return usersModel;
    }
  }

  Future<void> setUser(UsersModel usersModel) async {
    _currentUser = usersModel;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('LoggedInUser', usersModel.id!);
    notifyListeners();
  }

  Future<void> outUser() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("LoggedInUser");
    notifyListeners();
  }

  int? getCurrentUser() => _currentUser?.id;
}
