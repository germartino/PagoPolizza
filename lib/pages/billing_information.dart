import 'dart:developer';

import 'package:PagoPolizza/model/current_user.dart';
import 'package:PagoPolizza/model/database.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:PagoPolizza/pages/navdrawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:regexed_validator/regexed_validator.dart';

class BillingInformation extends StatefulWidget {
  final String rui;
  final String compagnia;
  final String importo;
  final String nPolizza;
  final String note;
  const BillingInformation(
      {Key? key,
      required this.rui,
      required this.compagnia,
      required this.importo,
      required this.nPolizza,
      required this.note})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => BillingInformationState();
}

class BillingInformationState extends State<BillingInformation> {
  final _formkey = GlobalKey<FormState>();
  late final String rui = widget.rui;
  late final String compagnia = widget.compagnia;
  late final String importo = widget.importo;
  late final String nPolizza = widget.nPolizza;
  late final String note = widget.note;
  String nazione = (CurrentUser.informazioni.containsKey("Nazione"))
      ? CurrentUser.informazioni["Nazione"].toString()
      : '';
  String regione = (CurrentUser.informazioni.containsKey("Regione"))
      ? CurrentUser.informazioni["Regione"].toString()
      : '';
  String citta = (CurrentUser.informazioni.containsKey("Citta"))
      ? CurrentUser.informazioni["Citta"].toString()
      : '';
  bool cityError = false;
  TextEditingController indirizzo =
      (CurrentUser.informazioni.containsKey("Indirizzo"))
          ? TextEditingController(
              text: CurrentUser.informazioni["Indirizzo"].toString())
          : TextEditingController();
  TextEditingController cap = (CurrentUser.informazioni.containsKey("CAP"))
      ? TextEditingController(text: CurrentUser.informazioni["CAP"].toString())
      : TextEditingController();

  @override
  void dispose() {
    indirizzo.dispose();
    cap.dispose();
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
                        'Inserisci l\'indirizzo di fatturazione',
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
                          CSCPicker(
                            currentCountry:
                                (nazione.isNotEmpty) ? nazione : null,
                            currentState: (regione.isNotEmpty) ? regione : null,
                            currentCity: (citta.isNotEmpty) ? citta : null,
                            showCities: true,
                            showStates: true,
                            defaultCountry: DefaultCountry.Italy,
                            flagState: CountryFlag.ENABLE,
                            countrySearchPlaceholder: "Nazione",
                            stateDropdownLabel: "Regione",
                            cityDropdownLabel: "Città",
                            dropdownDecoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1)),
                            disabledDropdownDecoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey.shade300,
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1)),
                            selectedItemStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            dropdownHeadingStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                            dropdownItemStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            dropdownDialogRadius: 10.0,
                            searchBarRadius: 10.0,
                            onCountryChanged: (value) {
                              setState(() {
                                nazione = value;
                              });
                            },
                            onStateChanged: (value) {
                              setState(() {
                                regione = (value != null) ? value : '';
                              });
                            },
                            onCityChanged: (value) {
                              setState(() {
                                citta = (value != null) ? value : '';
                              });
                            },
                          ),
                          if (cityError)
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Perfavore scegli la regione e la città',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.red[700],
                                ),
                              ),
                            ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          TextFormField(
                            controller: cap,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Perfavore inserisci il CAP';
                              } else if (!validator.postalCode(value)) {
                                return 'Il CAP inserito non è corretto';
                              } else {
                                return null;
                              }
                            },
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              labelText: "CAP",
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
                            controller: indirizzo,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Perfavore inserisci l\'indirizzo';
                              } else {
                                return null;
                              }
                            },
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              labelText: "Indirizzo",
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
                              if (nazione.isNotEmpty &&
                                  citta.isNotEmpty &&
                                  regione.isNotEmpty) {
                                setState(() {
                                  cityError = false;
                                });

                                if (_formkey.currentState!.validate()) {
                                  insertTransaction();
                                }
                              } else {
                                setState(() {
                                  _formkey.currentState!.validate();
                                  cityError = true;
                                });
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

  Future<void> insertTransaction() async {
    Map<String, String> toChange = {};
    if (CurrentUser.informazioni.containsKey("Nazione")) {
      if (CurrentUser.informazioni["Nazione"] != nazione) {
        toChange["Nazione"] = nazione;
        CurrentUser.informazioni["Nazione"] = nazione;
      }
    } else {
      toChange["Nazione"] = nazione;
      CurrentUser.informazioni["Nazione"] = nazione;
    }
    if (CurrentUser.informazioni.containsKey("Regione")) {
      if (CurrentUser.informazioni["Regione"] != regione) {
        toChange["Regione"] = regione;
        CurrentUser.informazioni["Regione"] = regione;
      }
    } else {
      toChange["Regione"] = regione;
      CurrentUser.informazioni["Regione"] = regione;
    }
    if (CurrentUser.informazioni.containsKey("Citta")) {
      if (CurrentUser.informazioni["Citta"] != citta) {
        toChange["Citta"] = citta;
        CurrentUser.informazioni["Citta"] = citta;
      }
    } else {
      toChange["Citta"] = citta;
      CurrentUser.informazioni["Citta"] = citta;
    }
    if (CurrentUser.informazioni.containsKey("Indirizzo")) {
      if (CurrentUser.informazioni["Indirizzo"] != indirizzo.text) {
        toChange["Indirizzo"] = indirizzo.text;
        CurrentUser.informazioni["Indirizzo"] = indirizzo.text;
      }
    } else {
      toChange["Indirizzo"] = indirizzo.text;
      CurrentUser.informazioni["Indirizzo"] = indirizzo.text;
    }
    if (CurrentUser.informazioni.containsKey("CAP")) {
      if (CurrentUser.informazioni["CAP"] != cap.text) {
        toChange["CAP"] = cap.text;
        CurrentUser.informazioni["CAP"] = cap.text;
      }
    } else {
      toChange["CAP"] = cap.text;
      CurrentUser.informazioni["CAP"] = cap.text;
    }

    if (toChange.isNotEmpty) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await Database.updateAddress(uid, toChange);
    }

    bool successo = false;
    if (int.parse(importo) > 70) {
      successo = true;
    }
    String uid = FirebaseAuth.instance.currentUser!.uid;
    int r = await Database.insertTransaction(
        rui, compagnia, int.parse(importo), nPolizza, note, successo, uid);
    if (r == 0) {
      await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.success,
            title: "Transazione eseguita con successo",
            confirmButtonColor: Color(0xffDF752C),
          ));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavDrawer()),
          (route) => false);
    } else if (r == 1) {
      await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.info,
            title: "Errore nella transazione",
            text: "Transazione annullata",
            confirmButtonColor: Color(0xffDF752C),
          ));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavDrawer()),
          (route) => false);
    }
  }
}
