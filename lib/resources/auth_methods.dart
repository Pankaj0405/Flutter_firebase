import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_quest/models/user.dart' as model;

class AuthMethods{
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore _firestore =FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async{
    User currentUser=_auth.currentUser!;

    DocumentSnapshot snap=await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);

  }

  //sign up the user
Future<String> signUpUser({
    required String email,
  required String password,
  required String username,
  required String bio,

}) async {
  String res="Some error occured";
  try{
if(email.isNotEmpty || password.isNotEmpty ||username.isNotEmpty || bio.isNotEmpty ){
  //register user
  UserCredential cred= await _auth.createUserWithEmailAndPassword(email: email, password: password);
  print(cred.user!.uid);

  //add user to our database

  model.User user= model.User(email: email, uid: cred.user!.uid
      , bio: bio, username: username);

  await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
  // await _firestore.collection('users').add({
  //   'username':username,
  //   'uid':cred.user!.uid,
  //   'email':email,
  //   'bio':bio,
  //   'followers':[],
  //   'following':[],
  // });
  res ="success";

}
  }
  catch(err){
res= err.toString();
  }
return res;
}

Future<String>  loginUser({
    required String email,
  required String password
}) async {
  String res="Some error occured";
  try{
if(email.isNotEmpty || password.isNotEmpty){
   await _auth.signInWithEmailAndPassword(email: email, password: password);
   res="success";
}else{
  res="Please enter alll the field";
}

  }
  catch(err){
res=err.toString();
  }
  return res;
}

Future<void> signout()async{
    await _auth.signOut();
}

}