import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:nontourage/services/authentication_service.dart';
import 'package:nontourage/shared/loading.dart';

import '../../shared/constants.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

   SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthenticationService _authenticationService = AuthenticationService();
  String email = '';
  String password = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent[400],
        elevation: 1.0,
        actions: <Widget>[
          TextButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('Register'),
              onPressed: (){
                widget.toggleView();
              },
          )
        ],
        title: const Text('Sign in to Nontourage'),
      ),
    //Body may end up being a map in the future
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child:Column(
            children: <Widget>[
              const SizedBox(height:20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                setState(() {
                  email = val;
                });
                },
              ),
              const SizedBox(height:20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter password 6 + characters long' : null,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ),
              const SizedBox(height:20.0),
              ElevatedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _authenticationService
                        .signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        loading = false;
                        error = 'Could not sign in';
                      });
                    }
                  }
              },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: const Text(
                  "sign in",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SignInButton(Buttons.Google,
                  onPressed: () => _authenticationService.loginGoogle()
              ),
              SignInButton(Buttons.Apple, onPressed: _authenticationService.loginApple()),
              SizedBox(height: 12.0),
              Text(error,
                  style: const TextStyle(color: Colors.red, fontSize:14.0)
              )
            ],
          ),

        ),
      ),
    );
  }
}
