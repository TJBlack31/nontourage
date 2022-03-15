import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nontourage/models/nontourage_user.dart';
import 'package:nontourage/models/photo_event.dart';
import 'package:nontourage/services/photo_event_crud.dart';
import 'package:nontourage/services/database.dart';
import 'package:nontourage/services/user_crud.dart';



class AuthenticationService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn(scopes: ['email']);



  //create user obj based on FirebaseUser

  NontourageUser? _userModelFromFirebaseUser(User user){
    return user != null ? NontourageUser(uid: user.uid) : null;
  }


  //sign in anon

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? firebaseUser = result.user;
      return _userModelFromFirebaseUser(firebaseUser!);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //auth change user stream
  Stream<NontourageUser?> get user {
    return _auth.authStateChanges()
        .map((User? user) => _userModelFromFirebaseUser(user!));
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;
      return _userModelFromFirebaseUser(firebaseUser!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with credential
  Future<UserCredential> _signInWithCredential(AuthCredential credential) =>
    _auth.signInWithCredential(credential);

  loginGoogle() async{
    try{
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken
      );
      final result = await _signInWithCredential(credential);
      print('${result.user?.displayName}');
    }catch(error){
      print(error);
    }
  }

  loginApple() async {
    try{

    }catch(error){

    }
  }


  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;
      await DatabaseService(uid: firebaseUser!.uid.toString())
          .updateUserData('portland', 'wilson', 100);
      return _userModelFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }



  
  
}