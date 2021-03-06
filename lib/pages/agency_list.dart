import 'dart:ui';
import 'package:PagoPolizza/model/database.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:PagoPolizza/model/agency.dart';
import 'package:PagoPolizza/pages/storico.dart';

class ListaAgenzie extends StatefulWidget {
  const ListaAgenzie({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ListaAgenzieState();
}

class ListaAgenzieState extends State<ListaAgenzie> {
  static String ruiForAdmin = '';

  Future<List<Agency>> getAgencies() async {
    List<Agency> temp = [];
    temp = await Database.getAllAgencies();
    return temp;
  }

  static bool isExpanded = false;
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
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.07),
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
                        'Lista agenzie',
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
                        'Scegli l\'agenzia di cui visualizzare lo storico',
                        style: GoogleFonts.ptSans(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    FutureBuilder(
                      future: getAgencies(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(
                            color: Color(0xffDF752C),
                            strokeWidth: 5,
                          );
                        } else {
                          if (snapshot.hasData) {
                            return Column(
                                children: _getPanel(context, snapshot.data));
                          } else {
                            return CircularProgressIndicator(
                              color: Color(0xffDF752C),
                              strokeWidth: 5,
                            );
                          }
                        }
                      },
                    )
                  ]),
                ),
              ),
            ),
          )
        ])));
  }

  List<Widget> _getPanel(BuildContext context, data) {
    List<Widget> panels = [];
    for (var i = 0; i < data.length; i++) {
      Widget elem = Container(
        width: MediaQuery.of(context).size.width * 0.8,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(stops: [
            0.03,
            0.03
          ], colors: [
            (data[i].getEnabled()) ? Color(0xff00701A) : Color(0xffA30000),
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
        child: InkWell(
            onTap: () {
              ruiForAdmin = data[i].getRUI();
              Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.easeInOut,
                    type: PageTransitionType.rightToLeftWithFade,
                    child: Storico(),
                  ));
            },
            child: data[i].getElementCollapsed(context, setState)),
      );
      panels.add(elem);
      panels.add(SizedBox(
        height: 10,
      ));
    }
    return panels;
  }
}
