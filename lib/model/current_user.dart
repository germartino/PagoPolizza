import 'package:PagoPolizza/model/agency.dart';
import 'package:PagoPolizza/model/database.dart';
import 'package:PagoPolizza/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentUser {
  static String name = '';
  static String surname = '';
  static String role = 'client';
  static String email = '';
  static List<String> codRui = [];

  CurrentUser(name, surname, role, codRui, email) {
    CurrentUser.name = name.toString();
    CurrentUser.surname = surname.toString();
    CurrentUser.role = role.toString();
    CurrentUser.codRui = codRui.cast<String>();
    CurrentUser.email = email.toString();
  }

  static Future<Widget> getProfile(context) async {
    Widget profilo = Column();
    if (role == 'client') {
      profilo = Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'NOME',
            style: GoogleFonts.montserrat(
                fontSize: 12.0,
                color: Color(0xff545454),
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            name,
            style: GoogleFonts.ptSans(
              fontSize: 14.0,
              color: Color(0xff545454),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'COGNOME / RAGIONE SOCIALE',
            style: GoogleFonts.montserrat(
                fontSize: 12.0,
                color: Color(0xff545454),
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            surname,
            style: GoogleFonts.ptSans(
              fontSize: 14.0,
              color: Color(0xff545454),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'EMAIL',
            style: GoogleFonts.montserrat(
                fontSize: 12.0,
                color: Color(0xff545454),
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            email,
            style: GoogleFonts.ptSans(
              fontSize: 14.0,
              color: Color(0xff545454),
            ),
          ),
        ),
      ]);
    } else if (role == 'agency') {
      Agency agenzia = await Database.getAgency(codRui[0]);
      profilo = Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'NOME',
            style: GoogleFonts.montserrat(
                fontSize: 12.0,
                color: Color(0xff545454),
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            name,
            style: GoogleFonts.ptSans(
              fontSize: 14.0,
              color: Color(0xff545454),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'CODICE RUI',
            style: GoogleFonts.montserrat(
                fontSize: 12.0,
                color: Color(0xff545454),
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            agenzia.ruiCode,
            style: GoogleFonts.ptSans(
              fontSize: 14.0,
              color: Color(0xff545454),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'INDIRIZZO SEDE',
            style: GoogleFonts.montserrat(
                fontSize: 12.0,
                color: Color(0xff545454),
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            agenzia.address,
            style: GoogleFonts.ptSans(
              fontSize: 14.0,
              color: Color(0xff545454),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'EMAIL',
            style: GoogleFonts.montserrat(
                fontSize: 12.0,
                color: Color(0xff545454),
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            email,
            style: GoogleFonts.ptSans(
              fontSize: 14.0,
              color: Color(0xff545454),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.8,
                  MediaQuery.of(context).size.height * 0.06),
              alignment: Alignment.center,
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                  side: BorderSide(color: Colors.black))),
          onPressed: () {
            ProfileState().logoFromGallery();
          },
          child: Text(
            'Modifica Logo',
            style: GoogleFonts.montserrat(
              fontSize: 15.0,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.8,
                  MediaQuery.of(context).size.height * 0.06),
              alignment: Alignment.center,
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                  side: BorderSide(color: Colors.black))),
          onPressed: () {
            ProfileState().bannerFromGallery();
          },
          child: Text(
            'Modifica Banner',
            style: GoogleFonts.montserrat(
              fontSize: 15.0,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ]);
    }
    return profilo;
  }
}
