import 'dart:developer';
import 'dart:ui';
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
import 'package:PagoPolizza/model/transaction.dart';

List<Transaction> getList() {
  List<Transaction> temp = [];
  if (HomeState.userType == 'client') {
    temp.add(Transaction(
      true,
      '07/12/2021',
      '150.50',
      '23987598',
      'Allianz Bank Financial Advisors S.p.A.',
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no.',
    ));
    temp.add(
      Transaction(
        false,
        '05/12/2021',
        '70.35',
        '23987598',
        'Allianz Bank Financial Advisors S.p.A.',
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no.',
      ),
    );
    temp.add(
      Transaction(
        false,
        '30/11/2021',
        '70.35',
        '23987598',
        'Allianz Bank Financial Advisors S.p.A.',
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no.',
      ),
    );
    temp.add(Transaction(
      true,
      '15/09/2021',
      '750',
      '23987598',
      'Allianz Bank Financial Advisors S.p.A.',
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no.',
    ));
  } else {
    temp.add(Transaction.agencyConstructor(
        true,
        '07/12/2021',
        '150.50',
        '23987598',
        'Allianz Bank Financial Advisors S.p.A.',
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no.',
        'Alessio Ambruoso'));
    temp.add(Transaction.agencyConstructor(
        false,
        '05/12/2021',
        '70.35',
        '23987598',
        'Allianz Bank Financial Advisors S.p.A.',
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no.',
        'Marco Borrelli'));
    temp.add(Transaction.agencyConstructor(
        false,
        '30/11/2021',
        '70.35',
        '23987598',
        'Allianz Bank Financial Advisors S.p.A.',
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no.',
        'Roberto Veneruso'));
    temp.add(Transaction.agencyConstructor(
        true,
        '15/09/2021',
        '750',
        '23987598',
        'Allianz Bank Financial Advisors S.p.A.',
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no.',
        'Gerardo Martino'));
  }
  return temp;
}

class Storico extends StatefulWidget {
  const Storico({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StoricoState();
}

class StoricoState extends State<Storico> {
  List<Transaction> transactions = getList();
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
            child: (HomeState.userType == 'admin')
                ? Row(
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
                              image:
                                  AssetImage('assets/pagopolizza_bianco.png'),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Padding(
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
                        'Storico Pagamenti',
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
                        'Visualizza lo storico dei pagamenti',
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
    for (var i = 0; i < transactions.length; i++) {
      panels.add(transactions[i].getElement(context));
      panels.add(SizedBox(
        height: 10,
      ));
    }
    return panels;
  }
}
