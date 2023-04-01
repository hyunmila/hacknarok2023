import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name = "hyunmila";
  String level = 'level: 1';
  Image profileAvatar = Image.asset('assets/images/82153266.jpg');
  List visitedList = ['test1', 'test2','test3','test4','test5'];
  List favouriteList = ['test1','test2'];

  User(this.name, this.level, this.profileAvatar, this.visitedList, this.favouriteList);
  User.fromDB(this.name) {
    fetch(name);
  }

  void fetch(String user) async{
    final db = FirebaseFirestore.instance;

    await db.collection("profiles").where("name", isEqualTo: user).get().then((data) {
      name = data.docs[0].data()["name"];
      level = data.docs[0].data()["level"];
      visitedList = data.docs[0].data()["visitedList"];
      favouriteList = data.docs[0].data()["favouriteList"];
    });
  }
}