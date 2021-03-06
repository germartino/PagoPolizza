import 'dart:convert';
import 'package:PagoPolizza/model/database.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:PagoPolizza/pages/choice_agency.dart';
import 'package:PagoPolizza/pages/navdrawer.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:PagoPolizza/pages/home.dart';
import 'package:page_transition/page_transition.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ScanQRCodeState();
}

class ScanQRCodeState extends State<ScanQRCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  bool isPressed = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: null,
        appBar: null,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffDF752C),
            ),
            child: Stack(children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    left: MediaQuery.of(context).size.width * 0.05),
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Ionicons.chevron_back_outline,
                        color: Color(0xffffffff), size: 25)),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.08),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image(
                          width: MediaQuery.of(context).size.width * 0.5,
                          image: AssetImage('assets/pagopolizza_bianco.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Assicurati la semplicit??.',
                            style: GoogleFonts.lato(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05,
                          bottom: MediaQuery.of(context).size.height * 0.03,
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Inquadra QR Code.',
                          style: GoogleFonts.ptSans(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.topCenter,
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.48,
                        child: QRView(
                          key: qrKey,
                          onQRViewCreated: _onQRViewCreated,
                          overlay: QrScannerOverlayShape(
                            borderColor: Colors.black,
                            borderWidth: 10,
                            borderRadius: 10,
                            cutOutSize: 300,
                            borderLength: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () => changeFlash(),
                        child: Icon(
                          isPressed
                              ? Ionicons.flash_outline
                              : Ionicons.flash_off_outline,
                          size: 24,
                        ),
                        style: ElevatedButton.styleFrom(
                            primary:
                                isPressed ? Color(0xffDF752C) : Colors.black,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(15)),
                      ),
                    )
                  ]),
                ),
              ),
            ]),
          ),
        ));
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      var json = jsonDecode(scanData.code.toString());
      await controller.stopCamera();
      if (FirebaseAuth.instance.currentUser != null) {
        await addAgency(json['rui'], json['password']);
      } else {
        await setAgency(json['rui'], json['password']);
      }
    });
  }

  Future<void> setAgency(rui, pass) async {
    int result = await Database.existAgency(rui, pass);

    if (result == 0) {
      ChoiceAgencyState.rui = rui;
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(child: Home(), type: PageTransitionType.fade),
          (route) => false);
    } else if (result == 1) {
      await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "Questa agenzia ?? stata disattivata",
            confirmButtonColor: Color(0xffDF752C),
          ));
    } else {
      await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "Codice QR errato",
            confirmButtonColor: Color(0xffDF752C),
          ));
    }
  }

  Future<void> addAgency(rui, pass) async {
    int result = await Database.existAgency(rui, pass);

    if (result == 0) {
      int r = await Database.addAgency(rui);
      if (r == -1) {
        await ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.warning,
              title: "Hai gi?? scelto quest\'agenzia",
              confirmButtonColor: Color(0xffDF752C),
            ));
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(child: NavDrawer(), type: PageTransitionType.fade),
            (route) => false);
      }
    } else if (result == 1) {
      await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "Questa agenzia ?? stata disattivata",
            confirmButtonColor: Color(0xffDF752C),
          ));
    } else {
      await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "Codice QR errato",
            confirmButtonColor: Color(0xffDF752C),
          ));
    }
  }

  void changeFlash() {
    setState(() {
      controller.toggleFlash();
      isPressed = !isPressed;
    });
  }
}
