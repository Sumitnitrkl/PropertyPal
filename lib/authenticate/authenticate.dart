
import 'package:flutter/cupertino.dart';
import 'package:untitled4/authenticate/register.dart';
import 'package:untitled4/authenticate/login.dart';


class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn=true;
  void toggleView(){
    setState(() {
      showSignIn=!showSignIn;
    });

  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn)
    return LoginPage(toggleView: toggleView);
    else
      return RegisterPage(toggleView: toggleView);
  }
}
