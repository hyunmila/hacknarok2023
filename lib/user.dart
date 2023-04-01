import 'package:flutter/material.dart';
import 'dart:math';

class User{
  String name = "hyunmila";
  Image profileAvatar = Image.asset('assets/images/82153266.jpg');
  List visitedList = ['test1', 'test2','test3','test4','test5'];
  List favouriteList = ['test1','test2'];
  String levels(){
    // var level = (visitedList.length)*(1/2);
    var level = pow(visitedList.length, (1/2));
    level.floor();
    return ("level: "+level.round().toString());
  }
}
// lvl 1 = 0 i 1 miejsce
// lvl 2^2 = x
// x =4 sqrtx = 2
// x =0