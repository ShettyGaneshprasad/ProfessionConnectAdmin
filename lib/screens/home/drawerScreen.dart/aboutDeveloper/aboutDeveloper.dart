import 'package:ProfessionConnect/screens/home/drawerScreen.dart/aboutDeveloper/chinfye.dart';
import 'package:ProfessionConnect/screens/home/drawerScreen.dart/aboutDeveloper/gshetty.dart';
import 'package:ProfessionConnect/screens/home/drawerScreen.dart/aboutDeveloper/nikhita.dart';
import 'package:ProfessionConnect/screens/home/drawerScreen.dart/aboutDeveloper/shubham.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutDeveloper extends StatefulWidget {
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<AboutDeveloper>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff2FD159),
            title: Text("About Developer"),
            bottom: menu(),
          ),
          body: TabBarView(
            children: [GShetty(), Shubham(), Chinfye(), Nikhita()],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return TabBar(
      tabs: [
        Tab(
          child: Flexible(
              child: Text(
            "Ganesh Shetty",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          )),
          icon: Icon(Icons.code),
        ),
        Tab(
          child: Flexible(
              child: Text(
            "Shubham Kumar",
            style: TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          )),
          icon: Icon(Icons.code),
        ),
        Tab(
          child: Flexible(
              child: Text(
            "Chinmayee",
            style: TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          )),
          icon: Icon(Icons.code),
        ),
        Tab(
          child: Flexible(
              child: Text(
            "Nikhita",
            style: TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          )),
          icon: Icon(Icons.code),
        ),
      ],
    );
  }
}
