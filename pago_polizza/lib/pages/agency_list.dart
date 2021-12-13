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
import 'package:pago_polizza/model/transaction.dart';
import 'package:pago_polizza/model/agency.dart';
import 'package:pago_polizza/pages/storico.dart';

List<Agency> getList() {
  List<Agency> temp = [];
  temp.add(Agency(
    'Allianz Bank Financial Advisors S.p.A.',
    'A000076887',
    'Via delle vie, 3, Roma',
  ));
  temp.add(Agency(
    'Alleanza Assicurazioni',
    'A000075857',
    'Via Verdi, 30, Milano',
  ));
  temp.add(Agency(
    'Unipol Gruppo S.p.A',
    'A000072336',
    'Via Stalingrado, 45, Bologna',
  ));
  temp.add(Agency(
    'AXA S.p.A.',
    'A000072984',
    'Corso Como, 17, Milano',
  ));
  return temp;
}

List<Agency> agencies = getList();

class ListaAgenzie extends StatefulWidget {
  const ListaAgenzie({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ListaAgenzieState();
}

class ListaAgenzieState extends State<ListaAgenzie> {
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
                    Column(
                      children: _getPanel(context),
                    )
                  ]),
                ),
              ),
            ),
          )
        ])));
  }

  List<Widget> _getPanel(BuildContext context) {
    List<Widget> panels = [];
    for (var i = 0; i < agencies.length; i++) {
      Widget elem = Container(
          width: MediaQuery.of(context).size.width * 0.8,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: [0.03, 0.03], colors: [Color(0xffdf752c), Colors.white]),
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
              Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.easeInOut,
                    type: PageTransitionType.rightToLeftWithFade,
                    child: Storico(),
                  ));
            },
            child: agencies[i].getElementCollapsed(context),
          ));
      panels.add(elem);
      panels.add(SizedBox(
        height: 10,
      ));
    }
    return panels;
  }
}
