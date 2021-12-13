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

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UpdateProfileState();
}

class UpdateProfileState extends State<UpdateProfile> {
  final _formkey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  TextEditingController password = TextEditingController(text: 'nuovapassword');

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: null,
        appBar: null,
        body: SafeArea(
            child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(26.0),
              ),
              color: Color(0xffdf752c),
            ),
            child: Row(
              children: [
                if (HomeState.userType != 'admin')
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.002,
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.07,
                      ),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Ionicons.chevron_back_outline,
                              color: Color(0xffffffff), size: 25)),
                    ),
                  ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: (HomeState.userType == 'admin')
                          ? MediaQuery.of(context).size.width * 0.07
                          : 0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          scale: 5,
                          alignment: Alignment.centerLeft,
                          image: AssetImage('assets/pagopolizza_bianco.png'),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Il mio profilo',
                        style: GoogleFonts.montserrat(
                            fontSize: 23.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          if (HomeState.userType != 'admin')
                            TextFormField(
                              initialValue: (HomeState.userType == 'client')
                                  ? 'Mario'
                                  : 'Allianz Bank Financial Advisors S.p.A.',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Perfavore inserisci il nome';
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
                                labelText: "Nome",
                                labelStyle: GoogleFonts.ptSans(
                                  fontSize: 15.0,
                                  color: Color(0xff707070),
                                ),
                              ),
                            ),
                          if (HomeState.userType != 'admin')
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                          if (HomeState.userType != 'admin')
                            TextFormField(
                              initialValue: (HomeState.userType == 'client')
                                  ? 'Rossi'
                                  : 'A000076887',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Perfavore inserisci il cognome o la ragione sociale';
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
                                labelText: (HomeState.userType == 'client')
                                    ? 'Cognome o Ragione Sociale'
                                    : 'Codice RUI',
                                labelStyle: GoogleFonts.ptSans(
                                  fontSize: 15.0,
                                  color: Color(0xff707070),
                                ),
                              ),
                            ),
                          if (HomeState.userType == 'agency')
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                          if (HomeState.userType == 'agency')
                            TextFormField(
                              initialValue: 'Via delle vie, 3, Roma',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Perfavore inserisci l\'indirizzo della sede';
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
                                labelText: 'Indirizzo Sede',
                                labelStyle: GoogleFonts.ptSans(
                                  fontSize: 15.0,
                                  color: Color(0xff707070),
                                ),
                              ),
                            ),
                          if (HomeState.userType != 'admin')
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                          TextFormField(
                            initialValue: 'mario.rossi@pagopolizza.com',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Perfavore inserisci l\'email';
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
                                  borderSide: BorderSide(color: Colors.black)),
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
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          TextFormField(
                            initialValue: 'password',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Perfavore inserisci la vecchia password';
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
                                  borderSide: BorderSide(color: Colors.black)),
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
                              labelText: "Vecchia password",
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
                            controller: password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Perfavore inserisci la nuova password';
                              }
                              return null;
                            },
                            obscureText: !_passwordVisible1,
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _passwordVisible1
                                        ? Ionicons.eye_outline
                                        : Ionicons.eye_off_outline,
                                    color: Color(0xff9e9e9e),
                                    size: 25),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible1 = !_passwordVisible1;
                                  });
                                },
                              ),
                              labelText: "Nuova Password",
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
                            initialValue: 'nuovapassword',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Perfavore reinserisci la nuova password';
                              } else if (password.text != value) {
                                return 'La password inserita non corrisponde';
                              }
                              return null;
                            },
                            obscureText: !_passwordVisible2,
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _passwordVisible2
                                        ? Ionicons.eye_outline
                                        : Ionicons.eye_off_outline,
                                    color: Color(0xff9e9e9e),
                                    size: 25),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible2 = !_passwordVisible2;
                                  });
                                },
                              ),
                              labelText: "Conferma Password",
                              labelStyle: GoogleFonts.ptSans(
                                fontSize: 15.0,
                                color: Color(0xff707070),
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (HomeState.userType != 'admin')
                                  Expanded(
                                    flex: 0,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Annulla',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15.0,
                                          color: Color(0xffdf752c),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.06),
                                          alignment: Alignment.center,
                                          primary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(23),
                                              side: BorderSide(
                                                  color: Color(0xffdf752c)))),
                                    ),
                                  ),
                                if (HomeState.userType != 'admin')
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                Expanded(
                                  flex: 0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      //update profile
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Salva',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                            MediaQuery.of(context).size.height *
                                                0.06),
                                        alignment: Alignment.center,
                                        primary: Color(0xffdf752c),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(23))),
                                  ),
                                )
                              ])
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          )
        ])));
  }
}
