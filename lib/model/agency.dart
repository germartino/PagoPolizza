import 'dart:developer';
import 'dart:ui';
import 'package:PagoPolizza/model/database.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Agency {
  final String name;
  final String ruiCode;
  final String address;
  final String logo;
  final String banner;
  final String passRUI;
  final bool enabled;

  Agency(this.name, this.ruiCode, this.address, this.logo, this.banner,
      this.passRUI, this.enabled);

  String getRUI() {
    return ruiCode;
  }

  bool getEnabled() {
    return enabled;
  }

  Widget getElementCollapsed(BuildContext context, callback) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
      child: SizedBox(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 18, bottom: 17, right: 10),
              child: Row(children: [
                Flexible(
                  flex: 2,
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
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () async {
                        ArtDialogResponse response = await ArtSweetAlert.show(
                            context: context,
                            barrierDismissible: false,
                            artDialogArgs: ArtDialogArgs(
                              type: ArtSweetAlertType.question,
                              title: (enabled)
                                  ? "Vuoi disattivare l\'agenzia?"
                                  : "Vuoi attivare l\'agenzia?",
                              confirmButtonText:
                                  (enabled) ? "Disattiva" : "Attiva",
                              denyButtonText: "Annulla",
                              denyButtonColor: Colors.grey,
                              confirmButtonColor: Color(0xffDF752C),
                            ));

                        if (response.isTapConfirmButton) {
                          ArtDialogResponse delete = await ArtSweetAlert.show(
                              barrierDismissible: false,
                              context: context,
                              artDialogArgs: ArtDialogArgs(
                                type: ArtSweetAlertType.question,
                                title: "Sei sicuro?",
                                confirmButtonColor: Color(0xffDF752C),
                                confirmButtonText:
                                    (enabled) ? "Disattiva" : "Attiva",
                                denyButtonColor: Colors.grey,
                                denyButtonText: "Annulla",
                              ));
                          if (delete.isTapConfirmButton) {
                            bool attivazione = (enabled) ? false : true;
                            await Database.disableAgency(ruiCode, attivazione);

                            callback(() {
                              ArtSweetAlert.show(
                                  context: context,
                                  artDialogArgs: ArtDialogArgs(
                                    type: ArtSweetAlertType.success,
                                    title: (attivazione)
                                        ? "Agenzia attivata"
                                        : "Agenzia disattivata",
                                    confirmButtonColor: Color(0xffDF752C),
                                  ));
                            });
                          }
                          if (delete.isTapDenyButton) {
                            await ArtSweetAlert.show(
                                context: context,
                                artDialogArgs: ArtDialogArgs(
                                  type: ArtSweetAlertType.info,
                                  title: (enabled)
                                      ? "Agenzia non disattivata"
                                      : "Agenzia non attivata",
                                  confirmButtonColor: Color(0xffDF752C),
                                ));
                          }
                        }
                      },
                      child: Text(
                        (enabled) ? 'disattiva' : 'attiva',
                        style: GoogleFonts.montserrat(
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                          decorationColor:
                              (enabled) ? Color(0xffA30000) : Color(0xff00701A),
                          fontSize: 12.0,
                          color: Colors.transparent,
                          shadows: [
                            Shadow(
                                color: (enabled)
                                    ? Color(0xffA30000)
                                    : Color(0xff00701A),
                                offset: Offset(0, -2))
                          ],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
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
