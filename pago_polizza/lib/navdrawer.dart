import 'package:flutter/material.dart';
import 'package:pago_polizza/home.dart';
import 'package:pago_polizza/main.dart';
import 'package:pago_polizza/storico.dart';
import 'package:pago_polizza/support.dart';
import 'package:pago_polizza/profile.dart';

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
            leading: Icon(Icons.home_outlined, color: Colors.tealAccent[700], size: 30),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
                fontWeight: FontWeight.w800,
              ),
            ),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.person_outline, color: Colors.tealAccent[700], size: 30),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
                fontWeight: FontWeight.w800,
              ),
            ),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt_rounded, color: Colors.tealAccent[700], size: 30),
            title: Text(
              'Storico',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
                fontWeight: FontWeight.w800,
              ),
            ),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Storico()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.support_agent, color: Colors.tealAccent[700], size: 30),
            title: Text(
              'Help',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
                fontWeight: FontWeight.w800,
              ),
            ),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Support()),
              )
            },
          ),
          ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.tealAccent[700], size: 30),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w800,
                ),
              ),
              onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  )),
        ],
      ),
    );
  }
}
