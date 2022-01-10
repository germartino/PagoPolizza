import 'package:PagoPolizza/model/database.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:PagoPolizza/pages/navdrawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:PagoPolizza/pages/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:PagoPolizza/pages/scan_qr_code.dart';

class ChoiceAgency extends StatefulWidget {
  const ChoiceAgency({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChoiceAgencyState();
}

class ChoiceAgencyState extends State<ChoiceAgency> {
  final _formkey = GlobalKey<FormState>();
  final codRui = TextEditingController();
  final pass = TextEditingController();
  bool _passwordVisible = false;
  static String rui = '';

  @override
  void dispose() {
    pass.dispose();
    codRui.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: null,
        appBar: null,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffDF752C),
            ),
            child: Stack(children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
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
                      top: MediaQuery.of(context).size.height * 0.08),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image(
                          width: MediaQuery.of(context).size.width * 0.5,
                          image: AssetImage('assets/pagopolizza_bianco.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Assicurati la semplicità.',
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
                      topLeft: Radius.circular(60.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.08,
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1),
                      child: SizedBox(
                        child: Text(
                          'Inserisci Codice RUI e Password per visualizzare la tua Agenzia.',
                          style: GoogleFonts.ptSans(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: codRui,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Perfavore inserisci il Codice RUI';
                                }
                                return null;
                              },
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                suffixIcon: Icon(Ionicons.key_outline,
                                    color: Color(0xff9e9e9e), size: 25),
                                labelText: "Codice RUI",
                                labelStyle: GoogleFonts.ptSans(
                                  fontSize: 15.0,
                                  color: Color(0xff707070),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            TextFormField(
                              controller: pass,
                              obscureText: !_passwordVisible,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Perfavore inserisci la password';
                                }
                                return null;
                              },
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      _passwordVisible
                                          ? Ionicons.eye_outline
                                          : Ionicons.eye_off_outline,
                                      color: Color(0xff9e9e9e),
                                      size: 25),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                labelText: "Password",
                                labelStyle: GoogleFonts.ptSans(
                                  fontSize: 15.0,
                                  color: Color(0xff707070),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            ElevatedButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  if (FirebaseAuth.instance.currentUser !=
                                      null) {
                                    addAgency();
                                  } else {
                                    setAgency();
                                  }
                                }
                              },
                              child: Text(
                                'Conferma',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width * 0.45,
                                      MediaQuery.of(context).size.height *
                                          0.06),
                                  alignment: Alignment.center,
                                  primary: Color(0xffdf752c),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                              'oppure',
                              style: GoogleFonts.montserrat(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            ElevatedButton.icon(
                              icon: Icon(
                                Ionicons.qr_code_outline,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      child: ScanQRCode(),
                                      type: PageTransitionType.bottomToTop),
                                );
                              },
                              label: Text(
                                'Scan QR Code',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width * 0.45,
                                      MediaQuery.of(context).size.height *
                                          0.06),
                                  alignment: Alignment.center,
                                  primary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ));
  }

  void setAgency() async {
    int result = await Database.existAgency(codRui.text, pass.text);

    if (result == 0) {
      rui = codRui.text;
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(child: Home(), type: PageTransitionType.fade),
          (route) => false);
    } else if (result == 1) {
      await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "Questa agenzia è stata disattivata",
            confirmButtonColor: Color(0xffDF752C),
          ));
    } else {
      pass.clear();
      FocusScope.of(context).unfocus();
      await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "Codice RUI o Password errato",
            confirmButtonColor: Color(0xffDF752C),
          ));
    }
  }

  void addAgency() async {
    int result = await Database.existAgency(codRui.text, pass.text);

    if (result == 0) {
      await Database.addAgency(codRui.text);
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(child: NavDrawer(), type: PageTransitionType.fade),
          (route) => false);
    } else if (result == 1) {
      await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.warning,
            title: "Questa agenzia è stata disattivata",
            confirmButtonColor: Color(0xffDF752C),
          ));
    } else {
      pass.clear();
      FocusScope.of(context).unfocus();
      await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "Codice RUI o Password errato",
            confirmButtonColor: Color(0xffDF752C),
          ));
    }
  }
}
