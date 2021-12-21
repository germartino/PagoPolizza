import 'package:firebase_auth/firebase_auth.dart';

class CurrentUser {
  final User user;
  final String role;

  CurrentUser(this.user, this.role);
}
