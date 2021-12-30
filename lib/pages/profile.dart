import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:PagoPolizza/model/agency.dart';
import 'package:PagoPolizza/model/current_user.dart';
import 'package:PagoPolizza/model/database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:PagoPolizza/pages/login.dart';
import 'package:flutter/services.dart';
import 'package:PagoPolizza/pages/pagamento.dart';
import 'package:PagoPolizza/pages/register.dart';
import 'package:PagoPolizza/pages/navdrawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:PagoPolizza/main.dart';
import 'package:PagoPolizza/pages/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:PagoPolizza/pages/update_profile.dart';
import 'package:art_sweetalert/art_sweetalert.dart';

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
                      Column(children: [
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
                                    onTap: () async {
                                      await getAgency().then((value) =>
                                          Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    curve: Curves.easeInOut,
                                                    type: PageTransitionType
                                                        .rightToLeftWithFade,
                                                    child: UpdateProfile(
                                                        agenzia: value),
                                                  ))
                                              .then(
                                                  (value) => setState(() {})));
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
                      ]),
                      FutureBuilder(
                        future: CurrentUser.getProfile(context),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(
                              color: Color(0xffDF752C),
                              strokeWidth: 5,
                            );
                          } else {
                            if (snapshot.hasData) {
                              return snapshot.data;
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
          ]),
        ));
  }

  Future<Agency> getAgency() async {
    Agency a = Agency('', '', '', '', '', '');
    if (CurrentUser.role == 'agency') {
      a = await Database.getAgency(CurrentUser.codRui[0]);
    }
    return a;
  }

  void logoFromGallery(String rui, context) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      String logoUrl = await Database.uploadLogo(file);
      log(logoUrl.toString());
      String exLogo = await Database.getLogo(rui);
      await Database.deleteFromStorage(exLogo);
      await Database.updateAgencyLogo(logoUrl, rui, context);
    }
  }

  void bannerFromGallery(String rui, context) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      String bannerUrl = await Database.uploadBanner(file);
      String exBanner = await Database.getBanner(rui);
      await Database.deleteFromStorage(exBanner);
      await Database.updateAgencyBanner(bannerUrl, rui, context);
    }
  }
}
