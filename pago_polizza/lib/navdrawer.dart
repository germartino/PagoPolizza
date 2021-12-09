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
        ));
    /*padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Text(
                'PagoPolizza',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(color: Colors.tealAccent[700])),
          ListTile(
            leading: Icon(Icons.home_outlined,
                color: Colors.tealAccent[700], size: 30),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
                fontWeight: FontWeight.w800,
              ),
            ),
            onTap: () => {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                  (route) => false)
            },
          ),
          if (MyApp.userType == 'client' || MyApp.userType == 'agency')
            ListTile(
              leading:
                  Icon(Icons.person, color: Colors.tealAccent[700], size: 30),
              title: Text(
                'Profilo',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w800,
                ),
              ),
              onTap: () => {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Profile()),
                    (route) => false)
              },
            ),
          if (MyApp.userType == 'admin')
            ListTile(
              leading:
                  Icon(Icons.vpn_key, color: Colors.tealAccent[700], size: 30),
              title: Text('Modifica password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w800,
                  )),
              onTap: () => {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const UpdateP()),
                    (route) => false)
              },
            ),
          ListTile(
            leading: Icon(Icons.list_alt_rounded,
                color: Colors.tealAccent[700], size: 30),
            title: Text(
              'Storico',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
                fontWeight: FontWeight.w800,
              ),
            ),
            onTap: () => {
              (MyApp.userType == 'client' || MyApp.userType == 'agency')
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Storico()),
                      (route) => false)
                  : Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AgencyList()),
                      (route) => false)
            },
          ),
          if (MyApp.userType == 'client' || MyApp.userType == 'agency')
            ListTile(
              leading: Icon(Icons.support_agent,
                  color: Colors.tealAccent[700], size: 30),
              title: Text('Help',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w800,
                  )),
              onTap: () => {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Support()),
                    (route) => false)
              },
            ),
          ListTile(
              leading: Icon(Icons.exit_to_app,
                  color: Colors.tealAccent[700], size: 30),
              title: Text('Logout',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w800,
                  )),
              onTap: () => {
                    MyApp.logged = false,
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                        (route) => false)
                  })
        ],
      ),
    );*/
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
