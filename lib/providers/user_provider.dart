import 'package:flutter/widgets.dart';



import '../Models/user.dart';
import '../resources/auth-methode.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethodes _authMethods = AuthMethodes();

  User get getUser => _user!;
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
