import 'package:flutter/material.dart';
import 'package:pago_polizza/login.dart';
import 'package:pago_polizza/navdrawer.dart';
import 'package:pago_polizza/main.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:pago_polizza/home.dart';

class UpdateP extends StatelessWidget {
  const UpdateP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text("Profilo"),
          backgroundColor: Colors.tealAccent[700],
        ),
        body: (MyApp.userType == 'admin')
            ? DoubleBackToCloseApp(
                snackBar: const SnackBar(
                  content: Text('Premi di nuovo per uscire'),
                  backgroundColor: Color(0xff00bfa5),
                ),
                child: getPage(context),
              )
            : getPage(context));
  }
}

Padding getPage(context) {
  return Padding(
    padding: EdgeInsets.all(25),
    child: Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "PagoPolizza",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.tealAccent[700],
              ),
            ),
            Text(
              (MyApp.userType == 'admin')
                  ? "Update password"
                  : "Update Profile",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 20),
            if (MyApp.userType != 'admin')
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.tealAccent[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person_outline,
                        color: Colors.tealAccent[700], size: 30),
                    labelText: "New Name",
                    labelStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            if (MyApp.userType != 'admin')
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.tealAccent[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person,
                        color: Colors.tealAccent[700], size: 30),
                    labelText: (MyApp.userType == 'client')
                        ? "New Cognome/Ragione Sociale"
                        : "New Codice Agenzia",
                    labelStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            if (MyApp.userType != 'admin') SizedBox(height: 1),
            if (MyApp.userType != 'admin')
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.tealAccent[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: (MyApp.userType == 'client')
                        ? Icon(Icons.mail_outline,
                            color: Colors.tealAccent[700], size: 30)
                        : Icon(Icons.map,
                            color: Colors.tealAccent[700], size: 30),
                    labelText: (MyApp.userType == 'client')
                        ? "New Email"
                        : "New Località",
                    labelStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            if (MyApp.userType != 'admin') SizedBox(height: 1),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextFormField(
                obscureText: true,
                style: TextStyle(
                  color: Colors.tealAccent[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon:
                      Icon(Icons.lock, color: Colors.tealAccent[700], size: 30),
                  labelText: "Old Password",
                  labelStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            SizedBox(height: 1),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextFormField(
                obscureText: true,
                style: TextStyle(
                  color: Colors.tealAccent[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock_outline,
                      color: Colors.tealAccent[700], size: 30),
                  labelText: "New Password",
                  labelStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            SizedBox(height: 1),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextFormField(
                obscureText: true,
                style: TextStyle(
                  color: Colors.tealAccent[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock_outline,
                      color: Colors.tealAccent[700], size: 30),
                  labelText: "Confirm New Password",
                  labelStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 20),
                  primary: Colors.tealAccent[700],
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
                child: Text(
                  'Confirm Update',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
