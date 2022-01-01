import 'package:firebase_database/firebase_database.dart';
import 'package:scnews/Models/usermodel.dart';

class UserDao {
  final DatabaseReference _userRef =
      // FirebaseDatabase.instance.reference().child('messages');
      FirebaseDatabase.instance.reference().child('users');
  void saveUser(UserModel user) {
    _userRef.push().set(user.toJson());
  }

  Query getUserQuery() {
    return _userRef;
  }
}
