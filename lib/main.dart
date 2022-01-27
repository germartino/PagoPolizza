import 'package:PagoPolizza/model/current_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:PagoPolizza/pages/choice_agency.dart';
import 'package:PagoPolizza/pages/login.dart';
import 'package:flutter/services.dart';
import 'package:PagoPolizza/pages/navdrawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'PagoPolizza';
  var broadStream =
      SimpleConnectionChecker().onConnectionChange.asBroadcastStream();

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primaryColor: Color(0xffDF752C),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: SplashScreen(),
        builder: (context, child) {
          return StreamBuilder(
            stream: broadStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  appBar: null,
                  drawer: null,
                  body: SafeArea(
                    child: DoubleBackToCloseApp(
                      child: CircularProgressIndicator(
                        color: Color(0xffDF752C),
                        strokeWidth: 5,
                      ),
                      snackBar: const SnackBar(
                        content: Text('Premi di nuovo per uscire'),
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ),
                );
              } else {
                if (snapshot.data == true) {
                  return child!;
                } else {
                  return Scaffold(
                    appBar: null,
                    drawer: null,
                    body: SafeArea(
                      child: DoubleBackToCloseApp(
                        child: Stack(children: [
                          Center(
                            child: CircularProgressIndicator(
                              color: Color(0xffDF752C),
                              strokeWidth: 5,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              alignment: Alignment.center,
                              color: Color(0xffDF752C),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Icon(
                                          Ionicons.information_circle_outline,
                                          color: Colors.black,
                                          size: 30)),
                                  TextSpan(
                                    text:
                                        "Nessuna connessione internet presente",
                                    style: GoogleFonts.lato(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          ),
                        ]),
                        snackBar: const SnackBar(
                          content: Text('Premi di nuovo per uscire'),
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                  );
                }
              }
            },
          );
        },
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String qrCode = 'Unknown';

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkLogged(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                drawer: null,
                appBar: null,
                body: Center(
                    child: CircularProgressIndicator(
                  color: Color(0xffDF752C),
                  strokeWidth: 5,
                )));
          } else {
            return buildWidget(context);
          }
        });
  }

  Widget buildWidget(BuildContext context) {
    return Scaffold(
        drawer: null,
        appBar: null,
        body: SafeArea(
          child: DoubleBackToCloseApp(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffDF752C), Color(0xffFFFFFF)],
                  begin: FractionalOffset(0, 0.3),
                  end: const FractionalOffset(0, 4),
                ),
                image: DecorationImage(
                    image: AssetImage('assets/watermark.png'),
                    opacity: 0.2,
                    scale: 2,
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.centerLeft),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image(
                        width: MediaQuery.of(context).size.width * 0.6,
                        image: AssetImage('assets/pagopolizza_bianco.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Assicurati la semplicità.',
                        style: GoogleFonts.lato(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage('assets/logo_bianco.png'),
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              icon: Icon(
                                Ionicons.log_in_outline,
                                color: Colors.black,
                                size: 20,
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    MediaQuery.of(context).size.height * 0.06),
                                alignment: Alignment.center,
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                      curve: Curves.easeInOut,
                                      type: PageTransitionType.bottomToTop,
                                      child: Login(),
                                    ));
                              },
                              label: Text(
                                'Accedi',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            ElevatedButton.icon(
                              icon: Icon(
                                Icons.work,
                                color: Colors.white,
                                size: 20,
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    MediaQuery.of(context).size.height * 0.06),
                                alignment: Alignment.center,
                                primary: Color(0xff000000),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                      curve: Curves.easeInOut,
                                      type: PageTransitionType.bottomToTop,
                                      child: ChoiceAgency(),
                                    ));
                              },
                              label: Text(
                                'Scegli agenzia',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ])),
                ],
              ),
            ),
            snackBar: const SnackBar(
              content: Text('Premi di nuovo per uscire'),
              backgroundColor: Colors.black,
            ),
          ),
        ));
  }

  Future<void> checkLogged() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('utenti');
      DocumentSnapshot snap = await users.doc(user.uid).get();
      CurrentUser(snap["Nome"], snap["Cognome"], snap["Ruolo"],
          snap["CodiceRUI"], user.email, snap["Informazioni"]);

      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavDrawer()),
      );
    }
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  late Image logo = Image.asset('assets/logo_completo_bianco.png');
  late Image watermark = Image.asset('assets/watermark.png');

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () async {
      Navigator.pushReplacement(
          context,
          PageTransition(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 700),
            type: PageTransitionType.fade,
            child: MainPage(title: "PagoPolizza"),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Future.wait([
            precacheImage(logo.image, context),
            precacheImage(watermark.image, context)
          ]),
          builder: (BuildContext context, AsyncSnapshot snap) {
            if (snap.connectionState != ConnectionState.waiting) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffDF752C), Color(0xffFFFFFF)],
                    begin: FractionalOffset(0, 0.3),
                    end: const FractionalOffset(0, 4),
                  ),
                  image: DecorationImage(
                      image: watermark.image,
                      opacity: 0.2,
                      scale: 2,
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.centerLeft),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.1),
                          child: Image(
                            image: logo.image,
                            fit: BoxFit.scaleDown,
                            width: MediaQuery.of(context).size.width * 0.70,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        'Assicurati la semplicità.',
                        style: GoogleFonts.lato(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]),
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffDF752C), Color(0xffFFFFFF)],
                    begin: FractionalOffset(0, 0.3),
                    end: const FractionalOffset(0, 4),
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.1),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ]),
              );
            }
          }),
    );
  }
}
