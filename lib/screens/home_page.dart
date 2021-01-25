import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'email_signin.dart';
import 'email_register.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.0, -0.1),
            radius: 0.77,
            colors: [Colors.grey, Colors.grey[300]],
            stops: [0.1,1.0]
          )
        ),
        child: SafeArea(
          child: Column(
            children: [
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  RaisedButton(
                      child: Text("e-mail ile giriş yap"),
                      onPressed:() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                      }),
                  Spacer(),
                  RaisedButton(
                      child: Text("e-mail ile kayıt ol"),
                      onPressed:() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                      } ),
                  Spacer()
                ],
              ),
              RaisedButton(

                  child: Text("gmail ile giriş yap"),
                  onPressed:() async {
                    await Firebase.initializeApp();
                    try{
                      await signInWithGoogle();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                    }catch(e){
                      print(e);
                    }
                  } ),
        Spacer(),
            ],
          ),
        ),
      ),
    );
  }
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}
