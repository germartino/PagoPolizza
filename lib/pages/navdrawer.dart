import 'package:PagoPolizza/model/agency.dart';
import 'package:PagoPolizza/model/current_user.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:PagoPolizza/pages/agency_list.dart';
import 'package:PagoPolizza/pages/home.dart';
import 'package:PagoPolizza/pages/storico.dart';
import 'package:PagoPolizza/pages/profile.dart';
import 'package:PagoPolizza/pages/update_profile.dart';
import 'package:ionicons/ionicons.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NavDrawerState();
}

List<Widget> getPagesList() {
  List<Widget> temp = [];
  if (CurrentUser.role == 'admin') {
    temp.add(UpdateProfile(agenzia: Agency('', '', '', '', '', '', true)));
  } else {
    temp.add(Profile());
  }
  temp.add(Home());
  if (CurrentUser.role == 'admin') {
    temp.add(ListaAgenzie());
  } else {
    temp.add(Storico());
  }
  return temp;
}

class NavDrawerState extends State<NavDrawer> {
  int _selectedIndex = 1;
  late PageController _pageController;

  List<Widget> _pages = getPagesList();

  @override
  void initState() {
    _pageController = PageController(initialPage: _selectedIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DoubleBackToCloseApp(
          child: PageView(
            children: _pages,
            onPageChanged: changeIndex,
            controller: _pageController,
          ),
          snackBar: const SnackBar(
            content: Text('Premi di nuovo per uscire'),
            backgroundColor: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.black, size: 30),
        selectedItemColor: Colors.black,
        elevation: 5,
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
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
