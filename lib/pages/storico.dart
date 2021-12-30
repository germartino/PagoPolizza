import 'dart:developer';
import 'dart:ui';
import 'package:PagoPolizza/model/current_user.dart';
import 'package:PagoPolizza/model/database.dart';
import 'package:PagoPolizza/pages/agency_list.dart';
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
import 'package:PagoPolizza/model/transaction.dart';

class Storico extends StatefulWidget {
  const Storico({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StoricoState();
}

class StoricoState extends State<Storico> {
  Future<List<Transaction>> getTransactions() async {
    List<Transaction> temp = [];
    if (CurrentUser.role == 'client') {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      temp = await Database.getTransactionsClient(uid);
    } else if (CurrentUser.role == 'agency') {
      String rui = CurrentUser.codRui[0];
      temp = await Database.getTransactionsAgency(rui);
    } else if (CurrentUser.role == 'admin') {
      temp =
          await Database.getTransactionsAgency(ListaAgenzieState.ruiForAdmin);
    }
    return temp;
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
            child: (CurrentUser.role == 'admin')
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
                    FutureBuilder(
                      future: getTransactions(),
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
      panels.add(data[i].getElement(context));
      panels.add(SizedBox(
        height: 10,
      ));
    }
    return panels;
  }
}
