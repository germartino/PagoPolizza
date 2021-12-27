import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:PagoPolizza/model/agency.dart';
import 'package:PagoPolizza/model/current_user.dart';
import 'package:PagoPolizza/model/database.dart';
import 'package:PagoPolizza/pages/agency_list.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  var iconaPopup = Ionicons.menu_outline;
  final GlobalKey _menuKey = GlobalKey();
  int selectedAgency = 0;
  List<Agency> agenzie = [];

  Future<List<Agency>> getAgencies() async {
    List<Agency> agenzieTemp = [];
    User? usr = FirebaseAuth.instance.currentUser;
    if (usr != null) {
      for (var i = 0; i < CurrentUser.codRui.length; i++) {
        Agency temp = await Database.getAgency(CurrentUser.codRui[i]);
        agenzieTemp.add(temp);
      }
    } else {
      Agency temp = await Database.getAgency(ChoiceAgencyState.rui);
      agenzieTemp.add(temp);
    }
    return agenzieTemp;
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAgencies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(
              color: Color(0xffDF752C),
              strokeWidth: 5,
            );
          } else {
            if (snapshot.hasData) {
              return buildWidget(context, snapshot.data);
            } else {
              return CircularProgressIndicator(
                color: Color(0xffDF752C),
                strokeWidth: 5,
              );
            }
          }
        });
  }

  Widget buildWidget(context, agenzie) {
    final SimpleDialog dialog = SimpleDialog(
        title: Text('Scegli l\'agenzia'), children: getAgenciesItem(agenzie));
    Agency agenzia = agenzie[selectedAgency];
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
                    image: NetworkImage(agenzia.banner),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: FirebaseAuth.instance.currentUser != null
                        ? LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [Color(0xffdf752c), Colors.transparent])
                        : null,
                  ),
                  child: FirebaseAuth.instance.currentUser != null
                      ? Stack(children: [
                          if (CurrentUser.role == 'client')
                            Positioned(
                                left: MediaQuery.of(context).size.width * 0.03,
                                top: MediaQuery.of(context).size.height * 0.03,
                                child: ElevatedButton(
                                  child: Image(
                                    image: NetworkImage(agenzia.logo),
                                    fit: BoxFit.scaleDown,
                                    width: 30,
                                    alignment: Alignment.center,
                                  ),
                                  onPressed: () {
                                    showDialog<void>(
                                        context: context,
                                        builder: (context) => dialog);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(10),
                                  ),
                                )),
                          Positioned(
                              right: MediaQuery.of(context).size.width * 0.03,
                              top: MediaQuery.of(context).size.height * 0.03,
                              child: PopupMenuButton(
                                  iconSize: 20,
                                  onSelected: (value) => {
                                        if (CurrentUser.role == 'admin')
                                          {makeLogout(context)}
                                        else if (value == 0)
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
                                          {makeLogout(context)}
                                      },
                                  key: _menuKey,
                                  elevation: 3,
                                  offset: Offset(
                                      1,
                                      MediaQuery.of(context).size.height *
                                          0.07),
                                  shape: TooltipShape(),
                                  itemBuilder: (context) => [
                                        if (CurrentUser.role != 'admin')
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
                                          value: CurrentUser.role == 'admin'
                                              ? 0
                                              : 1,
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
                                    Container(
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
                                        )),
                                  ])))
                        ])
                      : null,
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
                    image: NetworkImage(agenzia.logo),
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
                        agenzia.name,
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
                        agenzia.ruiCode,
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
                        agenzia.address,
                        style: GoogleFonts.lato(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    if (CurrentUser.role == 'client')
                      ElevatedButton(
                        onPressed: () {
                          if (FirebaseAuth.instance.currentUser != null) {
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
                          FirebaseAuth.instance.currentUser != null
                              ? 'Paga ora'
                              : 'Registrati',
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
                    if (CurrentUser.role == 'agency')
                      ElevatedButton(
                        onPressed: () {
                          saveQRCode(agenzia);
                        },
                        child: Text(
                          'Scarica il QR Code',
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
                    if (CurrentUser.role == 'client' &&
                        FirebaseAuth.instance.currentUser != null)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                    if (CurrentUser.role == 'client' &&
                        FirebaseAuth.instance.currentUser != null &&
                        agenzie.length > 1)
                      ElevatedButton(
                        onPressed: () {
                          removeAgency(agenzie, agenzia.ruiCode);
                        },
                        child: Text(
                          'Rimuovi Agenzia',
                          style: GoogleFonts.montserrat(
                            fontSize: 15.0,
                            color: Color(0xffdf752c),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.45,
                                MediaQuery.of(context).size.height * 0.06),
                            alignment: Alignment.center,
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 2, color: Color(0xffdf752c)),
                                borderRadius: BorderRadius.circular(23))),
                      )
                  ])),
            ]),
          ),
        ),
      ),
    );
  }

  void saveQRCode(agenzia) async {
    try {
      String qr =
          jsonEncode({'rui': agenzia.ruiCode, 'password': agenzia.passRUI});

      final img = await QrPainter(
        data: qr,
        version: QrVersions.auto,
        color: Colors.black,
        emptyColor: Colors.white,
        gapless: true,
      ).toImage(2048);
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      final ts = DateTime.now().millisecondsSinceEpoch.toString();
      String path = '$tempPath/$ts.png';
      ByteData? painter = await CodePainter(qrImage: img)
          .toImageData(2048, format: ui.ImageByteFormat.png);
      if (painter != null) {
        await writeToFile(painter, path);
        bool? success = await GallerySaver.saveImage(path);
        if (success != null && success) {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "QRCode scaricato",
                confirmButtonColor: Color(0xffDF752C),
              ));
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  void makeLogout(context) async {
    await Database.logout();
    Navigator.pushReplacement(
        context,
        PageTransition(
          curve: Curves.easeInOut,
          type: PageTransitionType.fade,
          child: MyApp(),
        ));
  }

  List<SimpleDialogItem> getAgenciesItem(List<Agency> agenzie) {
    List<SimpleDialogItem> items = [];
    for (Agency item in agenzie) {
      items.add(SimpleDialogItem(
        icon: Image(
          image: NetworkImage(item.logo),
          fit: BoxFit.scaleDown,
          width: 36,
          height: 36,
        ),
        text: item.name,
        onPressed: () {
          Navigator.pop(context);
          setState(() {
            selectedAgency = agenzie.indexOf(item);
          });
        },
      ));
    }
    items.add(SimpleDialogItem(
      icon: Icon(
        Ionicons.add_circle,
        size: 36,
        color: Colors.black,
      ),
      text: 'Aggiungi agenzia',
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            PageTransition(
              curve: Curves.easeInOut,
              type: PageTransitionType.rightToLeftWithFade,
              child: ChoiceAgency(),
            ));
      },
    ));
    return items;
  }

  void removeAgency(List<Agency> agenzie, String rui) async {
    List<String> ruiCodes = [];
    for (Agency temp in agenzie) {
      if (temp.ruiCode != rui) {
        ruiCodes.add(temp.ruiCode);
      }
    }
    await Database.removeAgency(
        ruiCodes, FirebaseAuth.instance.currentUser!.uid, context);
    CurrentUser.codRui = ruiCodes;
    setState(() {
      selectedAgency = 0;
    });
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

class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onPressed})
      : super(key: key);

  final Widget icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: icon,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 13.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CodePainter extends CustomPainter {
  // ********************************* VARS ******************************** //

  final double margin;
  final ui.Image qrImage;
  late Paint vpaint;

  // ***************************** CONSTRUCTORS **************************** //

  CodePainter({required this.qrImage, this.margin = 30}) {
    vpaint = Paint()
      ..color = Colors.white
      ..style = ui.PaintingStyle.fill;
  }

  //***************************** PUBLIC METHODS *************************** //

  @override
  void paint(Canvas canvas, Size size) {
    // Draw everything in white.
    final rect = Rect.fromPoints(Offset.zero, Offset(size.width, size.height));
    canvas.drawRect(rect, vpaint);

    // Draw the image in the center.
    canvas.drawImage(qrImage, Offset(margin, margin), Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  ui.Picture toPicture(double size) {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    paint(canvas, Size(size, size));
    return recorder.endRecording();
  }

  Future<ui.Image> toImage(double size,
      {ui.ImageByteFormat format = ui.ImageByteFormat.png}) async {
    return await toPicture(size).toImage(size.toInt(), size.toInt());
  }

  Future<ByteData?> toImageData(double originalSize,
      {ui.ImageByteFormat format = ui.ImageByteFormat.png}) async {
    final image = await toImage(originalSize + margin * 2, format: format);
    return image.toByteData(format: format);
  }
}
