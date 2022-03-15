import 'package:flutter/material.dart';
import 'package:nontourage/models/nontourage_user.dart';
import 'package:nontourage/screens/home/home.dart';
import 'package:nontourage/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NontourageUser?>(context);
    print(user);

  //returns either Home or Authenticate Widgets
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }
  }
}
