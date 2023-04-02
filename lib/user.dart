import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name = "huanmila";
  Image profileAvatar = Image.asset('assets/images/82153266.jpg');
  Set visitedList = Set<String>();
  Set favouriteList = Set<String>();
  String levels(){
    // var level = (visitedList.length)*(1/2);
    var level = pow(visitedList.length, (1/2));
    level.floor();
    return ("level: "+level.round().toString());
  }

  User(this.name, this.profileAvatar, this.visitedList, this.favouriteList);
  User.fromDB(this.name) {
    fetch(name);
  }

  void fetch(String user) async {
    final db = FirebaseFirestore.instance;
    await db.collection("profiles").where("name", isEqualTo: user).get().then((data) {
      name = data.docs[0].data()["name"];
      visitedList = {...data.docs[0].data()["visitedList"]};
      favouriteList = {...data.docs[0].data()["favouriteList"]};
    });
  }

  void push() async {
    final db = FirebaseFirestore.instance;
    await db.collection("profiles").where("name", isEqualTo: name).get().then((data) {
      data.docs[0].reference.update({
        "visitedList": visitedList.toList(),
        "favouriteList": favouriteList.toList()
      });
    });
  }
}
