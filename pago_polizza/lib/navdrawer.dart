import 'package:flutter/material.dart';
import 'package:pago_polizza/agency_list.dart';
import 'package:pago_polizza/home.dart';
import 'package:pago_polizza/login.dart';
import 'package:pago_polizza/main.dart';
import 'package:pago_polizza/storico.dart';
import 'package:pago_polizza/support.dart';
import 'package:pago_polizza/profile.dart';
import 'package:pago_polizza/update_profile.dart';
import 'package:ionicons/ionicons.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NavDrawerState();
}

class NavDrawerState extends State<NavDrawer> {
  int _selectedIndex = 1;

  static const List<Widget> _pages = <Widget>[Profile(), Home(), Storico()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.black, size: 30),
        selectedItemColor: Colors.black,
        elevation: 3,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Ionicons.person_outline,
                color: Colors.black,
                size: 20,
              ),
              activeIcon: Icon(
                Ionicons.person,
                color: Colors.black,
                size: 30,
              ),
              label: 'Profilo'),
          BottomNavigationBarItem(
              icon: Icon(
                Ionicons.home_outline,
                color: Colors.black,
                size: 20,
              ),
              activeIcon: Icon(
                Ionicons.home,
                color: Colors.black,
                size: 30,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Ionicons.reader_outline,
                color: Colors.black,
                size: 20,
              ),
              activeIcon: Icon(
                Ionicons.reader,
                color: Colors.black,
                size: 30,
              ),
              label: "Storico"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
