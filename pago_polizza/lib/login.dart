import 'package:flutter/material.dart';
import 'package:pago_polizza/main.dart';
import 'package:pago_polizza/navdrawer.dart';
import 'package:pago_polizza/pagamento.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:pago_polizza/register.dart';

int press = 0;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  final controller = TextEditingController();
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Icon(Icons.person_outline, color: Colors.grey[300], size: 100),
                SizedBox(height: 13),
                Text(
                  "PagoPolizza",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.tealAccent[700],
                  ),
                ),
                Text(
                  "Esegui il login per continuare",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    controller: controller,
                    cursorColor: Colors.tealAccent[700],
                    style: TextStyle(
                      color: Colors.tealAccent[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.mail,
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
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    cursorColor: Colors.tealAccent[700],
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.tealAccent[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock,
                          color: Colors.tealAccent[700], size: 30),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Password dimenticata?",
                          style: TextStyle(
                            color: Colors.tealAccent[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ))
                  ],
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
                      String testo = controller.text;
                      if (testo == 'admin') MyApp.userType = 'admin';
                      if (testo == 'agency') MyApp.userType = 'agency';
                      if (testo == 'client' || testo == '')
                        MyApp.userType = 'client';
                      MyApp.logged = true;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Non hai un account? ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()),
                        );
                      },
                      child: Text(
                        "Registrati",
                        style: TextStyle(
                          color: Colors.tealAccent[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
