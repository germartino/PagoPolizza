import 'dart:developer';
import 'dart:ui';
import 'package:PagoPolizza/model/database.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:PagoPolizza/pages/login.dart';
import 'package:flutter/services.dart';
import 'package:PagoPolizza/pages/pagamento.dart';
import 'package:PagoPolizza/pages/register.dart';
import 'package:PagoPolizza/pages/navdrawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:PagoPolizza/main.dart';
import 'package:PagoPolizza/pages/home.dart';
import 'package:page_transition/page_transition.dart';

class InsertAgency extends StatefulWidget {
  const InsertAgency({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InsertAgencyState();
}

class InsertAgencyState extends State<InsertAgency> {
  bool valid = true;
  bool _passwordVisible = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController ruiCode = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController passRUI = TextEditingController();

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
                    top: MediaQuery.of(context).size.height * 0.04,
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Inserisci agenzia',
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
                        'Compila il form per inserire una nuova agenzia',
                        style: GoogleFonts.ptSans(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Perfavore inserisci il nome dell\'agenzia';
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
                              labelText: "Nome agenzia",
                              labelStyle: GoogleFonts.ptSans(
                                fontSize: 15.0,
                                color: Color(0xff707070),
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          TextFormField(
                            controller: email,
                            onChanged: (value) => valid = true,
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
                              suffixIcon: Icon(Ionicons.mail_outline,
                                  color: Color(0xff9e9e9e), size: 25),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              labelText: "Email",
                              labelStyle: GoogleFonts.ptSans(
                                fontSize: 15.0,
                                color: Color(0xff707070),
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          TextFormField(
                            controller: ruiCode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Perfavore inserisci il codice RUI';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: Icon(Ionicons.key_outline,
                                  color: Color(0xff9e9e9e), size: 25),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              labelText: "Codice RUI",
                              labelStyle: GoogleFonts.ptSans(
                                fontSize: 15.0,
                                color: Color(0xff707070),
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          TextFormField(
                            controller: address,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Perfavore inserisci l\'indirizzo dell\'agenzia';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: Icon(Ionicons.map_outline,
                                  color: Color(0xff9e9e9e), size: 25),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              labelText: "Indirizzo agenzia",
                              labelStyle: GoogleFonts.ptSans(
                                fontSize: 15.0,
                                color: Color(0xff707070),
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          TextFormField(
                            controller: passRUI,
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
                              errorMaxLines: 4,
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
                              labelText: "Password RUI",
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
                                InsertAgency();
                              }
                            },
                            child: Text(
                              'Inserisci',
                              style: GoogleFonts.montserrat(
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.45,
                                    MediaQuery.of(context).size.height * 0.06),
                                alignment: Alignment.center,
                                primary: Color(0xffdf752c),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(23))),
                          ),
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

  Future<void> InsertAgency() async {
    int result = await Database.createAgency(name.text, email.text,
        ruiCode.text, address.text, passRUI.text, context);

    if (result == 0) {
      await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.success,
            title: "Agenzia creata",
            confirmButtonColor: Color(0xffDF752C),
          ));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavDrawer()),
          (route) => false);
    } else if (result == -1) {
      valid = false;
      _formkey.currentState!.validate();
    }
  }
}
