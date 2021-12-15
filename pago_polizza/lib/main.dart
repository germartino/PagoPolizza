import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pago_polizza/pages/choice_agency.dart';
import 'package:pago_polizza/pages/login.dart';
import 'package:flutter/services.dart';
import 'package:pago_polizza/pages/pagamento.dart';
import 'package:pago_polizza/pages/register.dart';
import 'package:pago_polizza/pages/navdrawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pago_polizza/pages/scan_qr_code.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String userType = 'client';
  static final String title = 'PagoPolizza';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primaryColor: Color(0xffDF752C),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String qrCode = 'Unknown';
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: null,
        appBar: null,
        body: SafeArea(
          child: DoubleBackToCloseApp(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Stack(children: [
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03,
                        left: MediaQuery.of(context).size.width * 0.1),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Image(
                                width: MediaQuery.of(context).size.width * 0.5,
                                image: AssetImage(
                                    'assets/pagopolizza_arancio.png'))),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.width * 0.01),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Assicurati la semplicità.',
                              style: GoogleFonts.lato(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      ),
                      color: Color(0xffDF752C),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.2),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton.icon(
                                    icon: Icon(
                                      Icons.work,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.8,
                                          MediaQuery.of(context).size.height *
                                              0.06),
                                      alignment: Alignment.center,
                                      primary: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                            curve: Curves.easeInOut,
                                            type:
                                                PageTransitionType.bottomToTop,
                                            child: ChoiceAgency(),
                                          ));
                                    },
                                    label: Text(
                                      'Scegli Agenzia',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03),
                                  ElevatedButton.icon(
                                    icon: Icon(
                                      Ionicons.qr_code_outline,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.8,
                                          MediaQuery.of(context).size.height *
                                              0.06),
                                      alignment: Alignment.center,
                                      primary: Color(0xff000000),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                            curve: Curves.easeInOut,
                                            type:
                                                PageTransitionType.bottomToTop,
                                            child: ScanQRCode(),
                                          ));
                                    },
                                    label: Text(
                                      'Scan QR Code',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ])),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 300,
                    color: const Color(0xFFFFFFFF),
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                ),
              ]),
            ),
            snackBar: const SnackBar(
              content: Text('Premi di nuovo per uscire'),
              backgroundColor: Colors.black,
            ),
          ),
        ));
  }
}
