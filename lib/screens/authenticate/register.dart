import 'package:flutter/material.dart';
import 'package:nontourage/shared/constants.dart';
import 'package:nontourage/shared/loading.dart';

import '../../services/authentication_service.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthenticationService _authenticationService = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent[400],
        elevation: 1.0,
        title: const Text('Sign up to Nontourage'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign in'),
            onPressed: (){
              widget.toggleView();
            },

          )
        ],
      ),
      //Body may end up being a map in the future
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child:Column(
            children: <Widget>[
              SizedBox(height:20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
              ),
              SizedBox(height:20.0),
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
              SizedBox(height:20.0),
              ElevatedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _authenticationService
                        .registerWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = result.toString();
                        loading = false;
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 12.0),
              Text(error,
              style: TextStyle(color: Colors.red, fontSize:14.0)
                  )


            ],
          ),

        ),
      ),
    );
  }
}
