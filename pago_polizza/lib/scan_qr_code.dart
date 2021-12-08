import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pago_polizza/login.dart';
import 'package:flutter/services.dart';
import 'package:pago_polizza/pagamento.dart';
import 'package:pago_polizza/register.dart';
import 'package:pago_polizza/navdrawer.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pago_polizza/main.dart';
import 'package:pago_polizza/home.dart';
import 'package:page_transition/page_transition.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ScanQRCodeState();
}

class ScanQRCodeState extends State<ScanQRCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: null,
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffDF752C),
        ),
        child: Stack(children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.08,
                left: MediaQuery.of(context).size.width * 0.05),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Ionicons.chevron_back_outline,
                    color: Color(0xffffffff), size: 25)),
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/logo_Bianco.png'),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Lorem ipsum dolor sit amet.',
                        style: GoogleFonts.lato(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(60.0),
                ),
                color: Colors.white,
              ),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.1,
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Inquadra QR Code.',
                      style: GoogleFonts.ptSans(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: 300,
                    height: 300,
                    color: const Color(0xFFF9F9F9),
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      //do something with scanData.code
      Navigator.pushReplacement(
          context,
          PageTransition(
            curve: Curves.easeInOut,
            type: PageTransitionType.fade,
            child: Home(),
          ));
    });
  }
}
