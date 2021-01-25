import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                  child: Text("e-mail ile kayıt ol"),
                  onPressed:() async {
                    await Firebase.initializeApp();
                    await emailRegister();
                  } ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  emailRegister() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: mail,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('parolanız çok basit daha zor bir parola seçin');
      } else if (e.code == 'email-already-in-use') {
        print('bu email zaten kullanılıyor');
      }
    } catch (e) {
      print(e);
    }

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
