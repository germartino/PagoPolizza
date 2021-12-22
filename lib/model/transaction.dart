// ignore_for_file: file_names

import 'dart:ui';

import 'package:PagoPolizza/model/current_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:PagoPolizza/pages/home.dart';
import 'package:PagoPolizza/pages/storico.dart';
import 'package:PagoPolizza/model/custom_expansion_tile.dart';

class Transaction {
  final bool success;
  final String data;
  final String importo;
  final String nPolizza;
  final String compagnia;
  final String note;
  String intestatario = '';

  Transaction(this.success, this.data, this.importo, this.nPolizza,
      this.compagnia, this.note);

  Transaction.agencyConstructor(this.success, this.data, this.importo,
      this.nPolizza, this.compagnia, this.note, this.intestatario);

  Widget getElementCollapsed(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
      child: SizedBox(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 18, bottom: 17),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  (CurrentUser.role == 'client')
                      ? (success ? 'EFFETTUATO CON SUCCESSO' : "NON EFFETTUATO")
                      : intestatario.toUpperCase(),
                  style: GoogleFonts.montserrat(
                    fontSize: 12.0,
                    color: (CurrentUser.role == 'client')
                        ? (success ? Color(0xff00701A) : Color(0xffA30000))
                        : Color(0xffdf752c),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.only(bottom: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      child: Text.rich(
                        TextSpan(
                          style: GoogleFonts.ptSans(
                            fontSize: 13.0,
                            color: Color(0xff707070),
                          ),
                          children: [
                            TextSpan(
                              text: 'in data: ',
                            ),
                            TextSpan(
                              text: data,
                              style: GoogleFonts.ptSans(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Text.rich(
                        TextSpan(
                          style: GoogleFonts.ptSans(
                            fontSize: 13.0,
                            color: Color(0xff707070),
                          ),
                          children: [
                            TextSpan(
                              text: 'importo: ',
                            ),
                            TextSpan(
                              text: importo + '€',
                              style: GoogleFonts.ptSans(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getElementExpanded(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "N. POLIZZA",
                style: GoogleFonts.montserrat(
                  fontSize: 12.0,
                  color: Color(0xff545454),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  nPolizza,
                  style: GoogleFonts.ptSans(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.04,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "COMPAGNIA",
                  style: GoogleFonts.montserrat(
                    fontSize: 12.0,
                    color: Color(0xff545454),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  compagnia,
                  style: GoogleFonts.ptSans(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.04,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "NOTE",
                  style: GoogleFonts.montserrat(
                    fontSize: 12.0,
                    color: Color(0xff545454),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005,
                bottom: MediaQuery.of(context).size.height * 0.04,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  note,
                  style: GoogleFonts.ptSans(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getElement(context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(stops: [
            0.03,
            0.03
          ], colors: [
            (CurrentUser.role == 'client')
                ? (success ? Color(0xff00701A) : Color(0xffA30000))
                : Color(0xffdf752c),
            Colors.white
          ]),
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              offset: Offset(0, 3.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: CustomExpansionTile(
          borderColor: (CurrentUser.role == 'client')
              ? (success ? Color(0xff00701A) : Color(0xffA30000))
              : Color(0xffdf752c),
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          trailing: SizedBox(),
          title: getElementCollapsed(context),
          children: [getElementExpanded(context)],
        ));
  }
}
