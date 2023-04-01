
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

List<Widget> visitedList(){
  List<Widget> visited = [];
  for(var i=0;i<10;i++){
    visited.add(Container(
      height: 30,
      color: Colors.pink.shade200,
      child: Center(child: Text('Entry$i')),
  ));}
  return visited;
}
List<Widget> favouriteList(){
  List<Widget> favourite = [];
  for(var i=0;i<10;i++){
    favourite.add(Container(
      height: 30,
      color: Colors.cyan.shade400,
      child: Center(child: Text('Entry$i')),
  ));}
  return favourite;
}

class _UserProfileState extends State<UserProfile>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("User profile", style:GoogleFonts.getFont('Bai Jamjuree')),
        backgroundColor: Colors.purple.shade300,
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
        const SizedBox(
          width: 50,
          height: 20,
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children : [
              const SizedBox(
                width: 50,
                height: 50,
              ),
              SizedBox(
              width : 100,
              height : 100,
              child: Image.asset('assets/images/82153266.jpg')),
              const SizedBox(
                width: 50,
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('User name', style:GoogleFonts.getFont('Bai Jamjuree'), textScaleFactor: 1.5),
                  Text('User Level', style:GoogleFonts.getFont('Bai Jamjuree'), textScaleFactor: 1.5)
                ],
              )
            ]),
            const SizedBox(
              width: 50,
              height: 50,
              ),
              SizedBox(
                height: 50,
                child:
                Text('Recently visited places:', style: GoogleFonts.getFont('Bai Jamjuree'), textScaleFactor: 1.5, textAlign: TextAlign.center,)),
              Expanded(child: 
              ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[]+visitedList(),
              )),
                const SizedBox(
                height: 20,
              ),
              SizedBox(
                    height: 50,
                    child:
                  Text('User favourite places:', style: GoogleFonts.getFont('Bai Jamjuree'), textScaleFactor: 1.5, textAlign: TextAlign.center,)),
              Expanded(child: 
              ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[]+favouriteList(),
              ))
          ],
        ),
      ),
    );
  }
}