import 'package:flutter/material.dart';
import 'package:pago_polizza/agency_list.dart';
import 'package:pago_polizza/login.dart';
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
    );
  }
}
