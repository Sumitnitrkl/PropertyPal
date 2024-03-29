import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Wrapper.dart';
import 'auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyCSKF3SVkxl-NI9GEJz8cNrgK-Gu8TNt7U',
      appId: '1:765521806503:android:aab3677be825e82f220782',
      messagingSenderId: '765521806503',
      projectId: 'mozo-b8a10',
      storageBucket: 'mozo-b8a10.appspot.com',
    ),
  );


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers:[
      StreamProvider<User?>.value(value: AuthService().user, initialData: null,),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
         home: Wrapper(),
    ));
  }
}
