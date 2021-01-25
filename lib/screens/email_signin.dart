import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String mail;
  String password;
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
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged:(value){
                    mail = value;
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value){
                    password = value;
                  },
                ),
              ),
              RaisedButton(
                  child: Text("e-mail ile giriş yap"),
                  onPressed:() async {
                    await Firebase.initializeApp();
                    await emailLogIn();
                  } ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  emailLogIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mail,
          password: password
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Bu e-mail ile kayıtlı kullanıcı bulunamadı');
      } else if (e.code == 'wrong-password') {
        print('e-mail ve şifre uyuşmuyor');
      }
    }
  }

}
