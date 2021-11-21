import 'package:flutter/material.dart';
import 'package:pago_polizza/main.dart';
import 'package:pago_polizza/navdrawer.dart';
import 'package:pago_polizza/scanner.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.tealAccent[700],
      ),
      body: DoubleBackToCloseApp(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Icon(Icons.person_outline,
                        color: Colors.grey[300], size: 140),
                    SizedBox(height: 13),
                    Text(
                      MyApp.title,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent[700],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.tealAccent[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.account_balance,
                              color: Colors.tealAccent[700], size: 30),
                          labelText: "Name Agenzia",
                          labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.tealAccent[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.vpn_key,
                              color: Colors.tealAccent[700], size: 30),
                          labelText: "Codice RUI",
                          labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 20),
                          primary: Colors.tealAccent[700],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                        child: Text('Login'),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'or',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 20),
                          primary: Colors.tealAccent[700],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Scanner()),
                          );
                        },
                        child: Text('Scan QR Code'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          snackBar: const SnackBar(
            content: Text('Premi di nuovo per uscire'),
            backgroundColor: Color(0xff00bfa5),
          ),
      ),
    );
  }
}
