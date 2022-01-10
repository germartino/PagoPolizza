import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:PagoPolizza/model/agency.dart';
import 'package:PagoPolizza/model/current_user.dart';
import 'package:PagoPolizza/model/transaction.dart' as transazione;
import 'package:PagoPolizza/pages/home.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:random_password_generator/random_password_generator.dart';

class Database {
  //sign in User
  //return 0 if registered
  //return -1 if error
  static Future<int> signUser(email, pass, nome, cognome, rui) async {
    int r = 0;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      FirebaseFirestore.instance
          .collection('utenti')
          .doc(userCredential.user!.uid)
          .set({
        "Nome": nome,
        "Cognome": cognome,
        "Ruolo": "client",
        "CodiceRUI": [rui]
      });
      await userCredential.user!.sendEmailVerification();
      r = 0;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        r = -1;
      }
    }
    return r;
  }

  //login
  //return -1 if not logged
  //return 0 if logged
  static Future<int> login(email, pass, context) async {
    int r = -1;
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
    }

    if (user != null && !user.emailVerified) {
      ArtDialogResponse response = await ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "Devi prima confermare l'email",
            confirmButtonText: "OK",
            denyButtonText: "Reinvia email",
            denyButtonColor: Color(0xffDF752C),
            confirmButtonColor: Color(0xffDF752C),
          ));

      if (response.isTapDenyButton) {
        await user.sendEmailVerification();
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.success,
              title: "Email inviata",
              confirmButtonColor: Color(0xffDF752C),
            ));
      }
      r = -1;
    } else if (user != null && user.emailVerified) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('utenti');
      DocumentSnapshot snap = await users.doc(user.uid).get();
      if (snap["Ruolo"] == 'agency') {
        bool res = await checkIfEnabled(snap["CodiceRUI"][0]);
        if (res) {
          CurrentUser(snap["Nome"], snap["Cognome"], snap["Ruolo"],
              snap["CodiceRUI"], user.email);
          await ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "Benvenuto",
                confirmButtonColor: Color(0xffDF752C),
              ));
          r = 0;
        } else {
          await FirebaseAuth.instance.signOut();
          await ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.warning,
                title: "Questa agenzia è disattivata",
                confirmButtonColor: Color(0xffDF752C),
              ));
          r = -1;
        }
      } else {
        CurrentUser(snap["Nome"], snap["Cognome"], snap["Ruolo"],
            snap["CodiceRUI"], user.email);
        await ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.success,
              title: "Benvenuto",
              confirmButtonColor: Color(0xffDF752C),
            ));
        r = 0;
      }
    } else {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass);

        r = await login(email, pass, context);
      } on FirebaseAuthException catch (e) {
        print(e.toString());
        if (e.code == 'user-not-found') {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Email o Password errate",
                confirmButtonColor: Color(0xffDF752C),
              ));
        } else if (e.code == 'wrong-password') {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Email o Password errate",
                confirmButtonColor: Color(0xffDF752C),
              ));
        } else if (e.code == 'too-many-requests') {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Troppe richieste",
                text: 'Riprova più tardi',
                confirmButtonColor: Color(0xffDF752C),
              ));
        }
      }
    }
    return r;
  }

  //logout
  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    CurrentUser('', '', 'client', [], '');
  }

  //reset password
  //return -1 wrong email
  //return 0 email sent
  static Future<int> resetPassword(email, context) async {
    int r = 0;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: 'aaaaaa');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: "Non esiste un account con questa email",
              confirmButtonColor: Color(0xffDF752C),
            ));
        r = -1;
      } else if (e.code == 'wrong-password') {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.info,
              title: "Email inviata",
              confirmButtonColor: Color(0xffDF752C),
            ));
        r = 0;
      }
    }
    return r;
  }

  static Future<int> existAgency(rui, pass) async {
    int r = -1;
    await FirebaseFirestore.instance
        .collection('agenzie')
        .doc(rui)
        .get()
        .then((value) {
      if (pass == value.get('PasswordRUI')) {
        if (!value.get('Attiva')) {
          r = 1;
        } else {
          r = 0;
        }
      } else {
        r = -1;
      }
    }).catchError((e) {
      r = -1;
    });
    return r;
  }

  static Future<void> addAgency(rui) async {
    List<String> list = CurrentUser.codRui;
    list.add(rui);
    CurrentUser.codRui = list;
    await FirebaseFirestore.instance
        .collection('utenti')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'CodiceRUI': list})
        .then((value) {})
        .catchError((error) {});
  }

  static Future<Agency> getAgency(rui) async {
    Agency agenzia = Agency('', '', '', '', '', '', true);
    await FirebaseFirestore.instance
        .collection('agenzie')
        .doc(rui)
        .get()
        .then((value) {
      agenzia = Agency(
          value.get('Nome'),
          rui,
          value.get('Indirizzo'),
          value.get('Logo'),
          value.get('Banner'),
          value.get('PasswordRUI'),
          value.get('Attiva'));
    });
    return agenzia;
  }

  static Future<void> removeAgency(rui, uid, context) async {
    await FirebaseFirestore.instance
        .collection('utenti')
        .doc(uid)
        .update({'CodiceRUI': rui}).then((value) {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.success,
            title: "Agenzia eliminata",
            confirmButtonColor: Color(0xffDF752C),
          ));
    });
  }

  static Future<String> uploadLogo(File file) async {
    String linkLogo = '';
    String filename = 'logo_' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        math.Random().nextInt(100).toString();
    await FirebaseStorage.instance
        .ref()
        .child('Loghi/$filename')
        .putFile(file)
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
        linkLogo = value.toString();
      });
    });
    return linkLogo;
  }

  static Future<String> uploadBanner(File file) async {
    String linkBanner = '';
    String filename = 'banner_' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        math.Random().nextInt(100).toString();
    await FirebaseStorage.instance
        .ref()
        .child('Banner/$filename')
        .putFile(file)
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
        linkBanner = value.toString();
      });
    });

    return linkBanner;
  }

  static Future<void> deleteFromStorage(String url) async {
    await FirebaseStorage.instance.refFromURL(url).delete();
  }

  static Future<void> updateAgencyLogo(String url, String rui, context) async {
    await FirebaseFirestore.instance
        .collection('agenzie')
        .doc(rui)
        .update({'Logo': url}).then((value) {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.success,
            title: "Logo modificato",
            confirmButtonColor: Color(0xffDF752C),
          ));
    });
  }

  static Future<void> updateAgencyBanner(
      String url, String rui, context) async {
    await FirebaseFirestore.instance
        .collection('agenzie')
        .doc(rui)
        .update({'Banner': url}).then((value) {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.success,
            title: "Banner modificato",
            confirmButtonColor: Color(0xffDF752C),
          ));
    });
  }

  static Future<String> getLogo(String rui) async {
    String logo = '';
    await FirebaseFirestore.instance
        .collection('agenzie')
        .doc(rui)
        .get()
        .then((value) => logo = value['Logo']);
    return logo;
  }

  static Future<String> getBanner(String rui) async {
    String logo = '';
    await FirebaseFirestore.instance
        .collection('agenzie')
        .doc(rui)
        .get()
        .then((value) => logo = value['Banner']);
    return logo;
  }

  static Future<void> updateUser(uid, update) async {
    await FirebaseFirestore.instance
        .collection('utenti')
        .doc(uid)
        .update(update)
        .then((value) {
      if (update['Nome'] != null) {
        CurrentUser.name = update['Nome'];
      }
      if (update['Cognome'] != null) {
        CurrentUser.surname = update['Cognome'];
      }
    });
  }

  static Future<int> changePassword(oldPass, password) async {
    int r = -1;
    var user = await FirebaseAuth.instance.currentUser;
    log(user.toString());
    await user!
        .reauthenticateWithCredential(EmailAuthProvider.credential(
            email: CurrentUser.email, password: oldPass))
        .then((value) async {
      await user.updatePassword(password).then((value) {
        r = 0;
      }).catchError((error) {
        log(error.toString());
      });
    }).catchError((error) {
      log(error.toString());
      if (error.code == 'wrong-password') {
        log('si');
        r = 1;
      } else if (error.code == 'too-many-requests') {
        r = 2;
      }
    });
    return r;
  }

  static Future<void> updateAgency(rui, update) async {
    await FirebaseFirestore.instance
        .collection('agenzie')
        .doc(rui)
        .update(update);
  }

  static Future<List<transazione.Transaction>> getTransactionsClient(
      uid) async {
    List<transazione.Transaction> temp = [];
    await FirebaseFirestore.instance
        .collection('transazioni')
        .where('uidUtente', isEqualTo: uid)
        .orderBy('data', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        temp.add(transazione.Transaction(
            element.get('successo'),
            DateFormat('dd/MM/yyyy').format(element.get('data').toDate()),
            element.get('importo').toString(),
            element.get('nPolizza'),
            element.get('compagnia'),
            element.get('note'),
            CurrentUser.name.toString() +
                ' ' +
                CurrentUser.surname.toString()));
      }
    });
    return temp;
  }

  static Future<List<transazione.Transaction>> getTransactionsAgency(
      rui) async {
    List<transazione.Transaction> temp = [];
    await FirebaseFirestore.instance
        .collection('transazioni')
        .where('codRUI', isEqualTo: rui)
        .orderBy('data', descending: true)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        String uid = element.get('uidUtente');
        await FirebaseFirestore.instance
            .collection('utenti')
            .doc(uid)
            .get()
            .then((us) {
          temp.add(transazione.Transaction(
              element.get('successo'),
              DateFormat('dd/MM/yyyy').format(element.get('data').toDate()),
              element.get('importo').toString(),
              element.get('nPolizza'),
              element.get('compagnia'),
              element.get('note'),
              us.get('Nome').toString() + ' ' + us.get('Cognome').toString()));
        });
      }
    });
    return temp;
  }

  static Future<List<Agency>> getAllAgencies() async {
    List<Agency> temp = [];
    await FirebaseFirestore.instance.collection('agenzie').get().then((value) {
      for (var element in value.docs) {
        temp.add(Agency(
            element.get('Nome'),
            element.id,
            element.get('Indirizzo'),
            element.get('Logo'),
            element.get('Banner'),
            element.get('PasswordRUI'),
            element.get('Attiva')));
      }
    });
    return temp;
  }

  static Future<int> insertTransaction(
      rui, compagnia, importo, nPolizza, note, success, uid) async {
    int r = -1;
    await FirebaseFirestore.instance.collection('transazioni').add({
      'codRUI': rui,
      'compagnia': compagnia,
      'importo': importo,
      'nPolizza': nPolizza,
      'note': note,
      'successo': success,
      'uidUtente': uid,
      'data': FieldValue.serverTimestamp()
    }).then((value) {
      if (success) {
        r = 0;
      } else {
        r = 1;
      }
    }).catchError((error) {
      log(error.toString());
      r = -1;
    });
    return r;
  }

  static Future<int> createAgency(
      name, email, rui, address, passRUI, context) async {
    int r = -1;
    String password = RandomPasswordGenerator().randomPassword(
        letters: true,
        numbers: true,
        passwordLength: 10,
        specialChar: false,
        uppercase: true);
    try {
      FirebaseApp app = await Firebase.initializeApp(
          name: 'Secondary', options: Firebase.app().options);
      UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance.collection('agenzie').doc(rui).set({
        "Nome": name,
        "Banner":
            'https://firebasestorage.googleapis.com/v0/b/pagopolizza.appspot.com/o/Banner%2Fbanner_placeholder.jpg?alt=media&token=02a70600-5dfe-4ba4-97f7-aecb269e3d69',
        "Logo":
            'https://firebasestorage.googleapis.com/v0/b/pagopolizza.appspot.com/o/Loghi%2Flogo_placeholder.png?alt=media&token=9712fe34-0f1d-4ced-a3da-1e30232ab312',
        "Indirizzo": address,
        "PasswordRUI": passRUI
      }).then((value) async {
        await FirebaseFirestore.instance
            .collection('utenti')
            .doc(userCredential.user!.uid)
            .set({
          "Nome": '',
          "Cognome": '',
          "Ruolo": 'agency',
          "CodiceRUI": [rui]
        }).catchError((error) {
          log(error.toString());
        });
      }).catchError((err) {
        log(err.toString());
      });
      await userCredential.user!.sendEmailVerification();
      ArtDialogResponse response = await ArtSweetAlert.show(
          context: context,
          barrierDismissible: false,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.success,
              title: "Agenzia creata",
              text: "Copia la password",
              confirmButtonColor: Color(0xffDF752C),
              confirmButtonText: "Copia"));
      if (response.isTapConfirmButton) {
        Clipboard.setData(ClipboardData(text: password)).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Password copiata"),
              backgroundColor: Colors.black));
        });
      }
      r = 0;
      await app.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        r = -1;
      }
    }
    return r;
  }

  static Future<void> disableAgency(rui, active) async {
    await FirebaseFirestore.instance
        .collection('agenzie')
        .doc(rui)
        .update({"Attiva": active});
  }

  static Future<bool> checkIfEnabled(rui) async {
    bool active = false;
    await FirebaseFirestore.instance
        .collection('agenzie')
        .doc(rui)
        .get()
        .then((value) {
      active = value["Attiva"];
    });
    return active;
  }
}
