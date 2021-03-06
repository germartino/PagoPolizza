import 'dart:ui';
import 'package:PagoPolizza/model/database.dart';
import 'package:flutter/material.dart';
import 'package:PagoPolizza/pages/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();

  @override
  void dispose() {
    email.dispose();
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
                            'Assicurati la semplicit??.',
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
                              'Recupera Password',
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
                              'Inserisci la tua email.',
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
                                    } else if (!RegExp(
                                            '[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?')
                                        .hasMatch(value)) {
                                      return 'Perfavore inserisci una mail valida';
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
                                        0.07),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      resetPass();
                                    }
                                  },
                                  child: Text(
                                    'Invia email',
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

  void resetPass() async {
    int result = await Database.resetPassword(email.text, context);

    if (result == 0) {
      Navigator.pop(
          context,
          PageTransition(
            curve: Curves.easeInOut,
            type: PageTransitionType.rightToLeftWithFade,
            child: Login(),
          ));
    } else {
      email.clear();
      FocusScope.of(context).unfocus();
    }
  }
}
