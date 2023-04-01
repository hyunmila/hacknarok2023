
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'user.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  _UserProfileState createState() => _UserProfileState();
}

List<Widget> visitedList(List visitedList){
  List<Widget> visited = [];
  for(var i=0;i<visitedList.length;i++){
    visited.add(Container(
      height: 30,
      color: Colors.purple.shade200,
      child: Center(child: Text(visitedList[i]))));}
  return visited;
}

List<Widget> favouriteList(List favouriteList){
  List<Widget> favourite = [];
  for(var i=0;i<favouriteList.length;i++){
    favourite.add(Container(
      height: 30,
      color: Colors.purple.shade200,
      child: Center(child: Text(favouriteList[i])),));}
  return favourite;
}

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];
  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }
  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }
  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

class _UserProfileState extends State<UserProfile>{
  @override
  var user = User();
  Widget build(BuildContext context){
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text('User profile', style: TextStyle(
          // color: Colors.black, 
          fontSize: 20), textAlign: TextAlign.center),
        backgroundColor: Colors.pink.shade200,
        actions: [
          IconButton(
            // alignment: Alignment.topLeft,
            onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate());},
            icon: const Icon(Icons.search,
            color: Colors.black,
            
          )),
            IconButton(
            // alignment: Alignment.topLeft,
            onPressed: () {
            Navigator.pop(context);},
            icon: const Icon(Icons.map,
            color: Colors.black,
            
          ))
        ]),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            // BACKGROUND IMAGE
            image: AssetImage('assets/images/background1.jpg'), fit: BoxFit.cover)
            ),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
        const SizedBox(
          width: 50,
          height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children : [
              const SizedBox(
                width: 50,
                height: 50),
              // PROFILE AVATAR
              Container(
                width : 100,
                height : 100,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.pink.shade200,
                  borderRadius: BorderRadius.circular(20)),
                child: 
                ClipRRect(borderRadius: BorderRadius.circular(20), child:SizedBox.fromSize(
                  size: const Size.fromRadius(48),
                  child: user.profileAvatar)
                ) 
              ),
                const SizedBox(
                  width: 50,
                  height: 50),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // USER NAME AND LEVEL
                  Text(user.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, ), textAlign: TextAlign.center),
                  Text(user.level, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,)
                ])
            ]),
            const SizedBox(
              height: 50,
              ),
              const SizedBox(
                height: 40,
                child:
                    Text('Recently visited places', style: TextStyle(
                    fontSize: 17, 
                    fontWeight: FontWeight.bold,
                    )
                  ),
                ),
                // VISITED PLACES LIST
                // ignore: sized_box_for_whitespace
                Container(
                  height: 150,
                child:
                Expanded(child: 
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple.shade200,
                        style: BorderStyle.solid,
                        width: 12),
                      color: Colors.purple.shade200,
                      borderRadius: BorderRadius.circular(30)),
                    child:
                  ListView(
                    children: <Widget>[]+visitedList(user.visitedList))
                  )
              )
              ),
                const SizedBox(
                height: 25),
              const SizedBox(
                    height: 40,
                    child:
                    Text('User favourite places', style: TextStyle(
                    fontSize: 17, 
                    fontWeight: FontWeight.bold
                    )
                  ),
                  ),
                  // FAVOURITE PLACES LIST
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 150,
                    child:
              Expanded(child:
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.purple.shade200,
                    style: BorderStyle.solid,
                    width: 12),
                  color: Colors.purple.shade200,
                  borderRadius: BorderRadius.circular(30)),
                child:
              ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[]+favouriteList(user.favouriteList),
                )
              )
            )
                  ),
            const SizedBox(
                height: 25,)
          ],
        ),
      ),
      ),
    );
  }
}