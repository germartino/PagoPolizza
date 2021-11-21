import 'package:flutter/material.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:pago_polizza/navdrawer.dart';

class Support extends StatelessWidget {
  const Support({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Support"),
        backgroundColor: Colors.tealAccent[700],
      ),
      body: DoubleBackToCloseApp(
          child: Padding(
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
                      "Contact Us",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 20),
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
                          prefixIcon: Icon(Icons.person_outline,
                              color: Colors.tealAccent[700], size: 30),
                          labelText: "Name",
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
                          prefixIcon: Icon(Icons.person,
                              color: Colors.tealAccent[700], size: 30),
                          labelText: "Cognome/Ragione Sociale",
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
                          prefixIcon: Icon(Icons.mail_outline,
                              color: Colors.tealAccent[700], size: 30),
                          labelText: "Email",
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
                        onPressed: () {},
                        child: Text('Submit'),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          snackBar: const SnackBar(
            content: Text('Premi di nuovo per uscire'),
            backgroundColor: Color(0xff00bfa5),
          )),
    );
  }
}
