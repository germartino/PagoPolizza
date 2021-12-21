import 'dart:developer';
import 'dart:ui';
import 'package:flutter/gestures.dart';
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

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  bool _passwordVisible = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();

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
                      top: MediaQuery.of(context).size.height * 0.04),
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
                          top: MediaQuery.of(context).size.height * 0.01,
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
                    height: MediaQuery.of(context).size.height * 0.75,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.07,
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Login',
                              style: GoogleFonts.montserrat(
                                  fontSize: 23.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Inserisci le tue credenziali per continuare.',
                              style: GoogleFonts.ptSans(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: email,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Perfavore inserisci l\'email';
                                    } else if (value !=
                                            'client@pagopolizza.com' &&
                                        value != 'admin@pagopolizza.com' &&
                                        value != 'agency@pagopolizza.com') {
                                      return 'email errata';
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
                                    suffixIcon: Icon(Ionicons.mail_outline,
                                        color: Color(0xff9e9e9e), size: 25),
                                    labelText: "Email",
                                    labelStyle: GoogleFonts.ptSans(
                                      fontSize: 15.0,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Password dimenticata?',
                                        style: GoogleFonts.lato(
                                            fontSize: 14.0,
                                            color: Color(0xffDF752C),
                                            decoration:
                                                TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print('password dimenticata');
                                          }),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.07),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      HomeState.logged = true;
                                      HomeState.userType = email.text.substring(
                                          0, email.text.indexOf('@'));
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NavDrawer()),
                                          (route) => false);
                                    }
                                  },
                                  child: Text(
                                    'Accedi',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.45,
                                          MediaQuery.of(context).size.height *
                                              0.06),
                                      alignment: Alignment.center,
                                      primary: Color(0xffdf752c),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(23))),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )),
            ]),
          ),
        ));
  }
}
