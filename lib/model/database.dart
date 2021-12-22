import 'package:PagoPolizza/pages/home.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Database {
  //sign in User
  //return 0 if registered
  //return -1 if error
  static Future<int> signUser(email, pass, nome, cognome, rui) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: pass.text);
      FirebaseFirestore.instance
          .collection('utenti')
          .doc(userCredential.user!.uid)
          .set({
        "Nome": nome.text,
        "Cognome": cognome.text,
        "Ruolo": "client",
        "CodiceRUI": [rui]
      });
      await userCredential.user!.sendEmailVerification();
      return 0;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return -1;
      }
    } catch (e) {}
    return 1;
  }

  //login
  //return -1 if not logged
  //return 0 if logged
  static Future<int> login(email, pass, context) async {
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
          ));

      if (response.isTapDenyButton) {
        await user.sendEmailVerification();
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.success,
              title: "Email inviata",
            ));
      }
      return -1;
    } else if (user != null && user.emailVerified) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('utenti');
      DocumentSnapshot snap = await users.doc(user.uid).get();
      HomeState.logged = true;
      HomeState.userType = snap["Ruolo"].toString();
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.success,
            title: "Benvenuto",
          ));
      return 0;
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email.text, password: pass.text);
        login(email, pass, context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Email o Password errato",
              ));
        } else if (e.code == 'wrong-password') {
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Email o Password errato",
              ));
        }
      }
    }
    return -1;
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    HomeState.logged = false;
    HomeState.userType = 'client';
  }
}
