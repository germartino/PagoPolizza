import 'package:flutter/material.dart';
import 'package:pago_polizza/main.dart';
import 'package:pago_polizza/navdrawer.dart';
import 'package:pago_polizza/pagamento.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

int press = 0;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  String qrCode = 'Unknown';

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
                  SizedBox(height: 30),
                  Icon(Icons.person_outline,
                      color: Colors.grey[300], size: 140),
                  SizedBox(height: 13),
                  if ((press == 0 && MyApp.userType == 'client') ||
                      MyApp.userType == 'admin')
                    Text(
                      MyApp.title,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent[700],
                      ),
                    ),
                  if ((press == 1 && MyApp.userType == 'client') ||
                      MyApp.userType == 'agency')
                    Text(
                      'Nome agenzia',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent[700],
                      ),
                    ),
                  if (MyApp.userType == 'admin')
                    Text(
                      'Admin',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent[700],
                      ),
                    ),
                  SizedBox(height: 10),
                  if ((press == 1 && MyApp.userType == 'client') ||
                      MyApp.userType == 'agency')
                    Text(
                      'Codice RUI',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent[700],
                      ),
                    ),
                  if ((press == 1 && MyApp.userType == 'client') ||
                      MyApp.userType == 'agency')
                    SizedBox(height: 10),
                  if ((press == 1 && MyApp.userType == 'client') ||
                      MyApp.userType == 'agency')
                    Text(
                      'Località',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent[700],
                      ),
                    ),
                  SizedBox(height: 30),
                  if (press == 0 && MyApp.userType == 'client')
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
                  if (press == 0 && MyApp.userType == 'client')
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
                          prefixIcon: Icon(Icons.password,
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
                  if (press == 0 && MyApp.userType == 'client')
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 20),
                          primary: Colors.tealAccent[700],
                        ),
                        onPressed: () {
                          press = 1;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                        child: Text('Login'),
                      ),
                    ),
                  if (press == 0 && MyApp.userType == 'client')
                    SizedBox(height: 10),
                  if (press == 0 && MyApp.userType == 'client')
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
                  if (press == 0 && MyApp.userType == 'client')
                    SizedBox(height: 10),
                  if (press == 0 && MyApp.userType == 'client')
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 20),
                          primary: Colors.tealAccent[700],
                        ),
                        onPressed: () => scanQRCode(),
                        child: Text('Scan QR Code'),
                      ),
                    ),
                  if (press == 1 && MyApp.userType == 'client')
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
                                builder: (context) => const Pagamento()),
                          );
                        },
                        child: Text('Paga ora'),
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

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#008080',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
