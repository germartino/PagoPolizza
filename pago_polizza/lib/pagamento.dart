import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pago_polizza/home.dart';
import 'package:pago_polizza/main.dart';
import 'package:pago_polizza/navdrawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class Pagamento extends StatelessWidget {
  const Pagamento({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Pagamento"),
        backgroundColor: Colors.tealAccent[700],
      ),
      body: Padding(
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
                  "Compila per effettuare il pagamento  ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    cursorColor: Colors.tealAccent[700],
                    style: TextStyle(
                      color: Colors.tealAccent[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.pin,
                          color: Colors.tealAccent[700], size: 30),
                      labelText: "Numero polizza",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    cursorColor: Colors.tealAccent[700],
                    style: TextStyle(
                      color: Colors.tealAccent[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person,
                          color: Colors.tealAccent[700], size: 30),
                      labelText: "Compagnia",
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
                    cursorColor: Colors.tealAccent[700],
                    style: TextStyle(
                      color: Colors.tealAccent[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          new RegExp('^([0-9])+[.]?([0-9]*)'))
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.euro,
                          color: Colors.tealAccent[700], size: 30),
                      labelText: "Importo",
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
                    cursorColor: Colors.tealAccent[700],
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.tealAccent[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.notes_outlined,
                          color: Colors.tealAccent[700], size: 30),
                      labelText: "Note",
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
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                          (route) => false);
                    },
                    child: Text(
                      'Paga',
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
      ),
    );
  }
}
