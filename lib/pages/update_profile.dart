import 'dart:ui';
import 'package:PagoPolizza/model/agency.dart';
import 'package:PagoPolizza/model/current_user.dart';
import 'package:PagoPolizza/model/database.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class UpdateProfile extends StatefulWidget {
  final Agency agenzia;
  const UpdateProfile({Key? key, required this.agenzia}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UpdateProfileState();
}

class UpdateProfileState extends State<UpdateProfile> {
  final _formkey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  TextEditingController password = TextEditingController();
  late TextEditingController name = TextEditingController(
      text: CurrentUser.role == 'agency'
          ? widget.agenzia.name
          : CurrentUser.name);
  TextEditingController surname =
      TextEditingController(text: CurrentUser.surname);
  late TextEditingController address =
      TextEditingController(text: widget.agenzia.address);
  TextEditingController oldPass = TextEditingController();
  TextEditingController confPass = TextEditingController();
  late TextEditingController passRUI =
      TextEditingController(text: widget.agenzia.passRUI);
  bool oldPassError = false;
  bool passwordError = false;
  bool confPassError = false;

  @override
  void dispose() {
    password.dispose();
    name.dispose();
    surname.dispose();
    address.dispose();
    oldPass.dispose();
    confPass.dispose();
    passRUI.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: null,
      appBar: null,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(26.0),
                ),
                color: Color(0xffdf752c),
              ),
              child: Row(
                children: [
                  if (CurrentUser.role != 'admin')
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
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: (CurrentUser.role == 'admin')
                            ? MediaQuery.of(context).size.width * 0.07
                            : 0,
                      ),
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
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Il mio profilo',
                                style: GoogleFonts.montserrat(
                                    fontSize: 23.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  if (CurrentUser.role != 'admin')
                                    TextFormField(
                                      controller: name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Perfavore inserisci il nome';
                                        }
                                        return null;
                                      },
                                      cursorColor: Colors.black,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      decoration: InputDecoration(
                                        errorMaxLines: 4,
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: "Nome",
                                        labelStyle: GoogleFonts.ptSans(
                                          fontSize: 15.0,
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                    ),
                                  if (CurrentUser.role != 'admin')
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                  if (CurrentUser.role == 'client')
                                    TextFormField(
                                      controller: surname,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Perfavore inserisci il cognome o la ragione sociale';
                                        }
                                        return null;
                                      },
                                      cursorColor: Colors.black,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      decoration: InputDecoration(
                                        errorMaxLines: 4,
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: 'Cognome o Ragione Sociale',
                                        labelStyle: GoogleFonts.ptSans(
                                          fontSize: 15.0,
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                    ),
                                  if (CurrentUser.role == 'agency')
                                    TextFormField(
                                      controller: address,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Perfavore inserisci l\'indirizzo della sede';
                                        }
                                        return null;
                                      },
                                      cursorColor: Colors.black,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      decoration: InputDecoration(
                                        errorMaxLines: 4,
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: 'Indirizzo Sede',
                                        labelStyle: GoogleFonts.ptSans(
                                          fontSize: 15.0,
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                    ),
                                  if (CurrentUser.role == 'agency')
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                  if (CurrentUser.role == 'agency')
                                    TextFormField(
                                      controller: passRUI,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Perfavore inserisci la password per il codice RUI';
                                        } else {
                                          return null;
                                        }
                                      },
                                      cursorColor: Colors.black,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      decoration: InputDecoration(
                                        errorMaxLines: 4,
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        labelText: 'Password codice RUI',
                                        labelStyle: GoogleFonts.ptSans(
                                          fontSize: 15.0,
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                    ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                  TextFormField(
                                    controller: oldPass,
                                    onChanged: (value) {
                                      setState(() {
                                        oldPassError = false;
                                        _formkey.currentState!.validate();
                                      });
                                    },
                                    obscureText: !_passwordVisible,
                                    validator: (value) {
                                      if (oldPassError) {
                                        if (value == null || value.isEmpty) {
                                          return 'Perfavore inserisci la vecchia password';
                                        } else {
                                          return 'La password inserita è errata';
                                        }
                                      } else {
                                        return null;
                                      }
                                    },
                                    cursorColor: Colors.black,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                    decoration: InputDecoration(
                                      errorMaxLines: 4,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            _passwordVisible
                                                ? Ionicons.eye_outline
                                                : Ionicons.eye_off_outline,
                                            color: Color(0xff9e9e9e),
                                            size: 25),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                      labelText: "Vecchia password",
                                      labelStyle: GoogleFonts.ptSans(
                                        fontSize: 15.0,
                                        color: Color(0xff707070),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                  TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        passwordError = false;
                                        _formkey.currentState!.validate();
                                      });
                                    },
                                    controller: password,
                                    obscureText: !_passwordVisible1,
                                    validator: (value) {
                                      if (passwordError) {
                                        if (value == null || value.isEmpty) {
                                          return 'Perfavore inserisci la nuova password';
                                        } else if (!RegExp(
                                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                            .hasMatch(value)) {
                                          return 'La password deve contenere almeno 8 caratteri, una lettera maiuscola, una lettera minuscola e un numero';
                                        }
                                      } else {
                                        return null;
                                      }
                                    },
                                    cursorColor: Colors.black,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                    decoration: InputDecoration(
                                      errorMaxLines: 4,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            _passwordVisible1
                                                ? Ionicons.eye_outline
                                                : Ionicons.eye_off_outline,
                                            color: Color(0xff9e9e9e),
                                            size: 25),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible1 =
                                                !_passwordVisible1;
                                          });
                                        },
                                      ),
                                      labelText: "Nuova Password",
                                      labelStyle: GoogleFonts.ptSans(
                                        fontSize: 15.0,
                                        color: Color(0xff707070),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                  TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        confPassError = false;
                                        _formkey.currentState!.validate();
                                      });
                                    },
                                    controller: confPass,
                                    validator: (value) {
                                      if (confPassError) {
                                        if (value == null || value.isEmpty) {
                                          return 'Perfavore reinserisci la password';
                                        } else if (password.text != value) {
                                          return 'La password inserita non corrisponde';
                                        }
                                      } else {
                                        return null;
                                      }
                                    },
                                    obscureText: !_passwordVisible2,
                                    cursorColor: Colors.black,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                    decoration: InputDecoration(
                                      errorMaxLines: 4,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            _passwordVisible2
                                                ? Ionicons.eye_outline
                                                : Ionicons.eye_off_outline,
                                            color: Color(0xff9e9e9e),
                                            size: 25),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible2 =
                                                !_passwordVisible2;
                                          });
                                        },
                                      ),
                                      labelText: "Conferma Password",
                                      labelStyle: GoogleFonts.ptSans(
                                        fontSize: 15.0,
                                        color: Color(0xff707070),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (CurrentUser.role != 'admin')
                                        Expanded(
                                          flex: 0,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Annulla',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 15.0,
                                                color: Color(0xffdf752c),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.35,
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.06),
                                                alignment: Alignment.center,
                                                primary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            23),
                                                    side: BorderSide(
                                                        color: Color(
                                                            0xffdf752c)))),
                                          ),
                                        ),
                                      if (CurrentUser.role != 'admin')
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
                                      Expanded(
                                        flex: 0,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (_formkey.currentState!
                                                .validate()) {
                                              updateProfile(context);
                                            }
                                          },
                                          child: Text(
                                            'Salva',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.06),
                                              alignment: Alignment.center,
                                              primary: Color(0xffdf752c),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          23))),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateProfile(context) async {
    bool something = false;
    //change password think done
    if (oldPass.text.isNotEmpty &&
        password.text.isNotEmpty &&
        confPass.text.isNotEmpty) {
      if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
          .hasMatch(password.text)) {
        setState(() {
          passwordError = true;
          _formkey.currentState!.validate();
        });
        return;
      } else {
        if (confPass.text != password.text) {
          setState(() {
            confPassError = true;
            _formkey.currentState!.validate();
          });
          return;
        } else {
          int result =
              await Database.changePassword(oldPass.text, password.text);
          if (result == 0) {
            something = true;
          } else if (result == 1) {
            setState(() {
              oldPassError = true;
              _formkey.currentState!.validate();
            });
            return;
          } else {
            ArtSweetAlert.show(
                context: context,
                artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.danger,
                  title: "Troppe richieste",
                  text: 'Riprova più tardi',
                  confirmButtonColor: Color(0xffDF752C),
                ));
            return;
          }
        }
      }
    } else if (oldPass.text.isNotEmpty ||
        password.text.isNotEmpty ||
        confPass.text.isNotEmpty) {
      if (oldPass.text.isEmpty) {
        setState(() {
          oldPassError = true;
          _formkey.currentState!.validate();
        });
      }
      if (password.text.isEmpty) {
        setState(() {
          passwordError = true;
          _formkey.currentState!.validate();
        });
      }
      if (confPass.text.isEmpty) {
        setState(() {
          confPassError = true;
          _formkey.currentState!.validate();
        });
      }
      return;
    } else {
      setState(() {
        oldPassError = false;
        passwordError = false;
        confPassError = false;
        _formkey.currentState!.validate();
      });
    }

    if (CurrentUser.role == 'client') {
      Map<String, String> update = {};
      if (name.text != CurrentUser.name) {
        update['Nome'] = name.text;
      }
      if (surname.text != CurrentUser.surname) {
        update['Cognome'] = surname.text;
      }
      if (update.isNotEmpty) {
        something = true;
        String uid = FirebaseAuth.instance.currentUser!.uid;
        await Database.updateUser(uid, update);
      }
    } else if (CurrentUser.role == 'agency') {
      Map<String, String> updateUser = {};
      Map<String, String> updateAgency = {};
      if (name.text != widget.agenzia.name) {
        updateAgency['Nome'] = name.text;
      }
      if (address.text != widget.agenzia.address) {
        updateAgency['Indirizzo'] = address.text;
      }
      if (passRUI.text != widget.agenzia.passRUI) {
        updateAgency['PasswordRUI'] = passRUI.text;
      }
      if (updateUser.isNotEmpty) {
        something = true;
        String uid = FirebaseAuth.instance.currentUser!.uid;
        await Database.updateUser(uid, updateUser);
      }
      if (updateAgency.isNotEmpty) {
        something = true;
        String rui = CurrentUser.codRui[0];
        await Database.updateAgency(rui, updateAgency);
      }
    }

    if (something) {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.success,
            title: "Profilo modificato",
            confirmButtonColor: Color(0xffDF752C),
          ));

      Navigator.pop(context);
    } else {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.info,
            title: "Nessuna modifica richiesta",
            text: 'Premi annulla per tornare indietro',
            confirmButtonColor: Color(0xffDF752C),
          ));
    }
  }
}
