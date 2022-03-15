import 'package:flutter/material.dart';
import 'package:nontourage/screens/authenticate/authenticate.dart';
import 'package:nontourage/services/authentication_service.dart';
import 'package:nontourage/services/database.dart';


class Home extends StatelessWidget {

  Home({Key? key}) : super(key: key);

  final AuthenticationService _auth = AuthenticationService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: AppBar(
          title: Text('Nontourage'),
          backgroundColor: Colors.orange[700],
          actions: <Widget>[
           TextButton.icon(
               icon: Icon(Icons.person),
               label: Text('sign out'),
               onPressed: () async {
                  await _auth.signOut().catchError(Future.error);
               },
           )
          ],
      ),
      body:Center(
        child: ElevatedButton(
          onPressed: () {

          },
          child: Text(
          "try it out",
            style: TextStyle(color: Colors.black)
          ),
        ),
      )

    );
  }
}
