import 'dart:ui';
import 'package:PagoPolizza/model/database.dart';
import 'package:PagoPolizza/pages/billing_information.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:PagoPolizza/pages/navdrawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';

class Pagamento extends StatefulWidget {
  final String rui;
  const Pagamento({Key? key, required this.rui}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PagamentoState();
}

class PagamentoState extends State<Pagamento> {
  final _formkey = GlobalKey<FormState>();
  late final String rui = widget.rui;
  TextEditingController nPolizza = TextEditingController();
  TextEditingController compagnia = TextEditingController();
  TextEditingController importo = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  void dispose() {
    nPolizza.dispose();
    compagnia.dispose();
    importo.dispose();
    note.dispose();
    super.dispose();
  }

  @override
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
                        'Pagamento',
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
                        'Compila il form per effettuare il pagamento',
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
                            controller: nPolizza,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Perfavore inserisci il numero della polizza';
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
                              labelText: "Numero polizza",
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
                            controller: compagnia,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Perfavore inserisci il nome della compagnia';
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
                              labelText: "Compagnia",
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
                            controller: importo,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Perfavore inserisci l\'importo';
                              } else if (!RegExp('^([0-9]+[.]?[0-9]+)\$')
                                  .hasMatch(value.toString())) {
                                return 'L\'importo inserito non ?? corretto';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[.0-9]'))
                            ],
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              suffixIcon: Icon(Ionicons.logo_euro,
                                  color: Color(0xff9e9e9e), size: 25),
                              labelText: "Importo",
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
                            controller: note,
                            validator: (value) {
                              return null;
                            },
                            minLines: 3,
                            maxLines: 5,
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff707070)),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: "Note",
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
                                Navigator.push(
                                    context,
                                    PageTransition(
                                      curve: Curves.easeInOut,
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
                                      child: BillingInformation(
                                          rui: rui,
                                          compagnia: compagnia.text,
                                          importo: importo.text,
                                          nPolizza: nPolizza.text,
                                          note: note.text),
                                    ));
                              }
                            },
                            child: Text(
                              'Paga ora',
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
}
