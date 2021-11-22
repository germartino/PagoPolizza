import 'package:flutter/material.dart';
import 'package:pago_polizza/agency_list.dart';
import 'package:pago_polizza/home.dart';
import 'package:pago_polizza/main.dart';
import 'package:pago_polizza/storico.dart';
import 'package:pago_polizza/support.dart';
import 'package:pago_polizza/profile.dart';
import 'package:pago_polizza/update_profile.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Text(
                'PagoPolizza',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(color: Colors.tealAccent[700])),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                  (route) => false)
            },
          ),
          if (MyApp.userType == 'client' || MyApp.userType == 'agency')
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profilo'),
              onTap: () => {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Profile()),
                    (route) => false)
              },
            ),
          if (MyApp.userType == 'admin')
            ListTile(
              leading: Icon(Icons.vpn_key),
              title: Text('Modifica password'),
              onTap: () => {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const UpdateP()),
                    (route) => false)
              },
            ),
          ListTile(
            leading: Icon(Icons.list_alt_rounded),
            title: Text('Storico'),
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
              leading: Icon(Icons.support_agent),
              title: Text('Help'),
              onTap: () => {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Support()),
                    (route) => false)
              },
            ),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                  (route) => false)),
        ],
      ),
    );
  }
}
