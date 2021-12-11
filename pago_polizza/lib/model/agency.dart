// ignore_for_file: file_names

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pago_polizza/pages/home.dart';
import 'package:pago_polizza/pages/storico.dart';
import 'package:pago_polizza/model/custom_expansion_tile.dart';

class Agency {
  final String name;
  final String ruiCode;
  final String address;

  Agency(this.name, this.ruiCode, this.address);

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
                  name,
                  style: GoogleFonts.montserrat(
                    fontSize: 12.0,
                    color: Color(0xffdf752c),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                child: Text.rich(
                  TextSpan(
                    style: GoogleFonts.ptSans(
                      fontSize: 13.0,
                      color: Color(0xff707070),
                    ),
                    children: [
                      TextSpan(
                        text: 'codice RUI: ',
                      ),
                      TextSpan(
                        text: ruiCode,
                        style: GoogleFonts.ptSans(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  child: Text.rich(
                    TextSpan(
                      style: GoogleFonts.ptSans(
                        fontSize: 13.0,
                        color: Color(0xff707070),
                      ),
                      children: [
                        TextSpan(
                          text: 'indirizzo: ',
                        ),
                        TextSpan(
                          text: address,
                          style: GoogleFonts.ptSans(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}