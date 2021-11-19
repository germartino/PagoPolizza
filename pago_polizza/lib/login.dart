import 'package:flutter/material.dart';
import 'package:pago_polizza/main.dart';
import 'package:pago_polizza/register.dart';


class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyApp()),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.tealAccent[700],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Icon(Icons.person_outline, color: Colors.grey[300], size: 100),
                SizedBox(height: 13),
                Text(
                  "PagoPolizza",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.tealAccent[700],
                  ),
                ),
                Text(
                  "sign in to continue",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.tealAccent[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.mail,
                          color: Colors.tealAccent[700], size: 30),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.tealAccent[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock,
                          color: Colors.tealAccent[700], size: 30),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: Colors.tealAccent[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ))
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20),
                      primary: Colors.tealAccent[700],
                    ),
                    onPressed: () {},
                    child: Text('Login'),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()),
                        );
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.tealAccent[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
