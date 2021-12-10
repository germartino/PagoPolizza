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
import 'package:pago_polizza/pages/update_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
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
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.centerLeft,
                      image: AssetImage('assets/logo_Bianco.png'),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Il mio profilo',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 23.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.01,
                                  right:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                child: InkWell(
                                    onTap: () => {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                curve: Curves.easeInOut,
                                                type: PageTransitionType
                                                    .rightToLeftWithFade,
                                                child: UpdateProfile(),
                                              ))
                                        },
                                    child: Container(
                                        alignment: Alignment.topRight,
                                        height: 35,
                                        width: 35,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shadows: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                          shape: StadiumBorder(
                                            side: BorderSide(
                                                color: Colors.white, width: 2),
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.edit_outlined,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                        ))),
                              ),
                            )
                          ],
                        ),
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            (HomeState.userType == 'client')
                                ? 'Mario'
                                : 'Allianz Bank Financial Advisors S.p.A.',
                            style: GoogleFonts.ptSans(
                              fontSize: 14.0,
                              color: Color(0xff545454),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            (HomeState.userType == 'client')
                                ? 'COGNOME / RAGIONE SOCIALE'
                                : 'CODICE RUI',
                            style: GoogleFonts.montserrat(
                                fontSize: 12.0,
                                color: Color(0xff545454),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            (HomeState.userType == 'client')
                                ? 'Rossi'
                                : 'A000076887',
                            style: GoogleFonts.ptSans(
                              fontSize: 14.0,
                              color: Color(0xff545454),
                            ),
                          ),
                        ),
                        if (HomeState.userType == 'agency')
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                        if (HomeState.userType == 'agency')
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
                        if (HomeState.userType == 'agency')
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                        if (HomeState.userType == 'agency')
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Via delle vie, 3, Roma',
                              style: GoogleFonts.ptSans(
                                fontSize: 14.0,
                                color: Color(0xff545454),
                              ),
                            ),
                          ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            (HomeState.userType == 'client')
                                ? 'client@pagopolizza.com'
                                : 'agency@pagopolizza.com',
                            style: GoogleFonts.ptSans(
                              fontSize: 14.0,
                              color: Color(0xff545454),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'PASSWORD',
                            style: GoogleFonts.montserrat(
                                fontSize: 12.0,
                                color: Color(0xff545454),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '*********',
                            style: GoogleFonts.ptSans(
                              fontSize: 14.0,
                              color: Color(0xff545454),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}
