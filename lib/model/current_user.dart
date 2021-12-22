class CurrentUser {
  static String name = '';
  static String surname = '';
  static String role = 'client';
  static List<String> codRui = [];

  CurrentUser(name, surname, role, codRui) {
    CurrentUser.name = name.toString();
    CurrentUser.surname = surname.toString();
    CurrentUser.role = role.toString();
    CurrentUser.codRui = codRui.cast<String>();
  }
}
