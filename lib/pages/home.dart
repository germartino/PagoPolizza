import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:PagoPolizza/pages/choice_agency.dart';
import 'package:PagoPolizza/pages/login.dart';
import 'package:flutter/services.dart';
import 'package:PagoPolizza/pages/pagamento.dart';
import 'package:PagoPolizza/pages/register.dart';
import 'package:PagoPolizza/pages/navdrawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:PagoPolizza/main.dart';
import 'package:PagoPolizza/pages/support.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  static bool logged = false;
  static String userType = 'client'; //can be 'client' or 'agency' or 'admin'
  var iconaPopup = Ionicons.menu_outline;
  final GlobalKey _menuKey = GlobalKey();
  String _chosenValue = 'Allianz';

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: null,
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Column(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/banner.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: logged
                        ? LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [Color(0xffdf752c), Colors.transparent])
                        : null,
                  ),
                  child: logged
                      ? PopupMenuButton(
                          iconSize: 20,
                          onCanceled: () => {
                                setState(() {
                                  iconaPopup = Ionicons.menu_outline;
                                })
                              },
                          onSelected: (value) => {
                                setState(() {
                                  iconaPopup = Ionicons.menu_outline;
                                }),
                                if (value == 0)
                                  {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          curve: Curves.easeInOut,
                                          type: PageTransitionType
                                              .rightToLeftWithFade,
                                          child: Support(),
                                        ))
                                  }
                                else
                                  {
                                    HomeState.logged = false,
                                    HomeState.userType = 'client',
                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                          curve: Curves.easeInOut,
                                          type: PageTransitionType.fade,
                                          child: MyApp(),
                                        ))
                                  }
                              },
                          key: _menuKey,
                          elevation: 3,
                          offset: Offset(
                              1, MediaQuery.of(context).size.height * 0.07),
                          shape: TooltipShape(),
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 0,
                                  child: ListTile(
                                    leading: Icon(
                                      Ionicons.call_outline,
                                      color: Color(0xffDF752C),
                                      size: 20,
                                    ),
                                    title: Text(
                                      "Assistenza",
                                      style: GoogleFonts.lato(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    leading: Icon(
                                      Ionicons.log_out_outline,
                                      color: Color(0xffDF752C),
                                      size: 20,
                                    ),
                                    title: Text(
                                      "Logout",
                                      style: GoogleFonts.lato(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                          icon: Stack(children: [
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.width * 0.01,
                              child: InkWell(
                                  onTap: () => {
                                        setState(() {
                                          dynamic state = _menuKey.currentState;
                                          state.showButtonMenu();
                                          iconaPopup = Ionicons.close_outline;
                                        })
                                      },
                                  child: Container(
                                      alignment: Alignment.topRight,
                                      height: 30,
                                      width: 30,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: StadiumBorder(
                                          side: BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          iconaPopup,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      ))),
                            ),
                          ]))
                      : null,
                ),
              ),
              if (HomeState.logged && HomeState.userType == 'client')
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              if (HomeState.logged && HomeState.userType == 'client')
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1),
                  child: Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 10,
                        child: DropdownButton2(
                          items: <String>['Allianz', 'Generali']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                          value: _chosenValue,
                          style: GoogleFonts.montserrat(
                            fontSize: 13.0,
                            color: Colors.black,
                          ),
                          icon: Icon(Ionicons.caret_down_outline,
                              color: Colors.black, size: 18),
                          onChanged: (value) {
                            setState(() {
                              _chosenValue = value.toString();
                            });
                          },
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          alignment: Alignment.center,
                          buttonElevation: 5,
                          underline: SizedBox(),
                          dropdownOverButton: true,
                          buttonDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.16),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          focusColor: Colors.white,
                          buttonPadding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.14),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 0,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                    curve: Curves.easeInOut,
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    child: ChoiceAgency(),
                                  ));
                            },
                            child: Icon(Ionicons.add_circle_outline,
                                color: Colors.green, size: 24),
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(), primary: Colors.white)),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 0,
                        child: ElevatedButton(
                            onPressed: () {
                              //remove selected agency
                            },
                            child: Icon(Ionicons.remove_circle_outline,
                                color: Colors.red, size: 24),
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(), primary: Colors.white)),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/insurance_logo.png'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'NOME AGENZIA',
                        style: GoogleFonts.montserrat(
                          fontSize: 13.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Allianz Bank Financial Advisors S.p.A.',
                        style: GoogleFonts.lato(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'CODICE RUI',
                        style: GoogleFonts.montserrat(
                            fontSize: 13.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'A000076887',
                        style: GoogleFonts.lato(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'INDIRIZZO SEDE',
                        style: GoogleFonts.montserrat(
                            fontSize: 13.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Via delle vie, 3, Roma',
                        style: GoogleFonts.lato(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    if (HomeState.userType == 'client')
                      ElevatedButton(
                        onPressed: () {
                          if (logged) {
                            Navigator.push(
                                context,
                                PageTransition(
                                  curve: Curves.easeInOut,
                                  type: PageTransitionType.rightToLeftWithFade,
                                  child: Pagamento(),
                                ));
                          } else {
                            Navigator.push(
                                context,
                                PageTransition(
                                  curve: Curves.easeInOut,
                                  type: PageTransitionType.rightToLeftWithFade,
                                  child: Register(),
                                ));
                          }
                        },
                        child: Text(
                          logged ? 'Paga ora' : 'Registrati',
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
                      )
                  ])),
            ]),
          ),
        ),
      ),
    );
  }
}

class TooltipShape extends ShapeBorder {
  const TooltipShape();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.lineTo(rrect.width - 30, 0);
    path.lineTo(rrect.width - 20, -10);
    path.lineTo(rrect.width - 10, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}
