import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
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
import 'package:pago_polizza/main.dart';
import 'package:pago_polizza/pages/home.dart';
import 'package:page_transition/page_transition.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _passwordVisible = false;
  bool _passwordVisible1 = false;
  bool ischecked1 = false;
  bool ischecked2 = false;
  bool valid = true;
  final _formkey = GlobalKey<FormState>();
  TextEditingController nome = new TextEditingController();
  TextEditingController cognome = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController confPass = new TextEditingController();

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
                      top: MediaQuery.of(context).size.height * 0.02),
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
                    height: MediaQuery.of(context).size.height * 0.80,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03,
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Registrazione',
                              style: GoogleFonts.montserrat(
                                  fontSize: 23.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Inserisci i tuoi dati e crea un nuovo account.',
                              style: GoogleFonts.ptSans(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: nome,
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
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                TextFormField(
                                  controller: cognome,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Perfavore inserisci cognome o ragione sociale';
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
                                    labelText: "Cognome o Ragione sociale",
                                    labelStyle: GoogleFonts.ptSans(
                                      fontSize: 15.0,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                TextFormField(
                                  onChanged: (value) => valid = true,
                                  controller: email,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Perfavore inserisci l\'email';
                                    } else if (!RegExp(
                                            '[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?')
                                        .hasMatch(value)) {
                                      return 'Perfavore inserisci una mail valida';
                                    } else if (!valid) {
                                      return 'Un account con questa email esiste già';
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
                                        0.01),
                                TextFormField(
                                  controller: pass,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Perfavore inserisci la password';
                                    } else if (!RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                        .hasMatch(value)) {
                                      return 'La password deve contenere almeno 8 caratteri, una lettera maiuscola, una lettera minuscola e un numero';
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
                                    errorMaxLines: 4,
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
                                TextFormField(
                                  controller: confPass,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Perfavore inserisci la password';
                                    } else if (value != pass.text) {
                                      return 'La password inserita deve essere uguale alla precedente';
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
                                    errorMaxLines: 2,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          _passwordVisible1
                                              ? Ionicons.eye_outline
                                              : Ionicons.eye_off_outline,
                                          color: Color(0xff9e9e9e),
                                          size: 25),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible1 =
                                              !_passwordVisible1;
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
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: CheckboxListTile(
                                    value: ischecked1,
                                    activeColor: Color(0xffDF752C),
                                    contentPadding: EdgeInsets.all(0),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        ischecked1 = value!;
                                      });
                                    },
                                    title: RichText(
                                        text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                        text: 'Ho letto e accetto ',
                                        style: GoogleFonts.lato(
                                          fontSize: 14.0,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                      TextSpan(
                                          text: 'Privacy Policy',
                                          style: GoogleFonts.lato(
                                              fontSize: 14.0,
                                              color: Color(0xffDF752C),
                                              decoration:
                                                  TextDecoration.underline),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              //see privacy policy
                                            }),
                                    ])),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: CheckboxListTile(
                                    activeColor: Color(0xffDF752C),
                                    value: ischecked2,
                                    contentPadding: EdgeInsets.all(0),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        ischecked2 = value!;
                                      });
                                    },
                                    title: RichText(
                                        text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                        text: 'Ho letto e accetto ',
                                        style: GoogleFonts.lato(
                                          fontSize: 14.0,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                      TextSpan(
                                          text: 'Termini e condizioni d\'uso',
                                          style: GoogleFonts.lato(
                                              fontSize: 14.0,
                                              color: Color(0xffDF752C),
                                              decoration:
                                                  TextDecoration.underline),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              //see Termini e condizioni d'uso
                                            }),
                                    ])),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formkey.currentState!.validate() &&
                                        ischecked1 &&
                                        ischecked2) {
                                      signUser();
                                    }
                                  },
                                  child: Text(
                                    'Registrati',
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
                                        0.01),
                                Container(
                                  alignment: Alignment.topCenter,
                                  child: RichText(
                                      text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                      text: 'Hai già un account? ',
                                      style: GoogleFonts.lato(
                                        fontSize: 14.0,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                    TextSpan(
                                        text: 'Accedi!',
                                        style: GoogleFonts.lato(
                                            fontSize: 14.0,
                                            color: Color(0xffDF752C),
                                            decoration:
                                                TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushReplacement(
                                                context,
                                                PageTransition(
                                                  curve: Curves.easeInOut,
                                                  type: PageTransitionType
                                                      .leftToRightWithFade,
                                                  child: Login(),
                                                ));
                                          }),
                                  ])),
                                ),
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

  Future<void> signUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: pass.text);
      FirebaseFirestore.instance
          .collection('utenti')
          .doc(userCredential.user!.uid)
          .set({
        "Nome": nome.text,
        "Cognome": cognome.text,
        "Ruolo": "client",
        "CodiceRUI": [ChoiceAgencyState.rui]
      });
      await userCredential.user!.sendEmailVerification();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        valid = false;
        _formkey.currentState!.validate();
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
