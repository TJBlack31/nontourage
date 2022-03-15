import 'package:flutter/material.dart';
import 'package:nontourage/models/nontourage_user.dart';
import 'package:nontourage/screens/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nontourage/services/authentication_service.dart';
import 'package:provider/provider.dart';






Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());



}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<NontourageUser?>.value(
      value: AuthenticationService().user,
      initialData: null,
      catchError: (_, err) => null,
      child: const MaterialApp(
        home: AuthWrapper(),
      ),
    );
  }
}

