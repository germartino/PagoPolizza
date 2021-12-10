import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pago_polizza/pages/login.dart';
import 'package:flutter/services.dart';
import 'package:pago_polizza/pages/pagamento.dart';
import 'package:pago_polizza/pages/register.dart';
import 'package:pago_polizza/pages/navdrawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pago_polizza/main.dart';
import 'package:pago_polizza/pages/home.dart';
import 'package:page_transition/page_transition.dart';

class ChoiceAgency extends StatefulWidget {
  const ChoiceAgency({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChoiceAgencyState();
}

class ChoiceAgencyState extends State<ChoiceAgency> {
  bool _passwordVisible = false;
  final _formkey = GlobalKey<FormState>();
  final controller = TextEditingController();
  void dispose() {
    controller.dispose();
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
                      top: MediaQuery.of(context).size.height * 0.10),
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
                      topLeft: Radius.circular(60.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.1,
                          horizontal: MediaQuery.of(context).size.width * 0.1),
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
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
                                    MediaQuery.of(context).size.height * 0.05),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Perfavore inserisci la password';
                                }
                                return null;
                              },
                              obscureText: !_passwordVisible,
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
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      PageTransition(
                                          child: Home(),
                                          type: PageTransitionType.fade),
                                      (route) => false);
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
                                      borderRadius: BorderRadius.circular(23))),
                            )
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
}
