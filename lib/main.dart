import 'package:financial_frontend/account/AccountDetail.dart';
import 'package:financial_frontend/home/HomeDetail.dart';
import 'package:financial_frontend/learning/LearningDetail.dart';
import 'package:flutter/material.dart';

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Router(),
    );
  }
}

class Router extends StatelessWidget {

  Color backGround = Color.fromARGB(255, 110, 110, 110);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: backGround,
      body: Center(
          child: Column(children: [
        Expanded(child: Container(
            padding: const EdgeInsets.all(16),
            child: const Text("BEM VINDO", style: TextStyle(fontSize: 20, color: Colors.white)))),
        Expanded(child: Container(
          alignment: Alignment.topCenter,
          child: ElevatedButton(
            onPressed: () => entrar(context,backGround),
            child: const Text("ENTRAR", style: TextStyle(fontSize: 20)),
          ),
        ),)
      ])),
    ));
  }

  void entrar(BuildContext context, Color background) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => NavigationExample(background: background,)));
  }
}

class NavigationExample extends StatefulWidget {
  NavigationExample({super.key, required this.background});
  Color background;
  @override
  State<NavigationExample> createState() => _NavigationExampleState(background: this.background);
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 1;
  Color background;
  _NavigationExampleState({required this.background});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: background,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle),
            icon: Icon(Icons.account_circle_outlined, color: Colors.white),
            label: 'Conta',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined, color: Colors.white,),
            label: 'Casa',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined, color: Colors.white),
            label: 'Aprender',
          ),
        ],
      ),
      body: <Widget>[
        AccountDetail(background:this.background),
        HomeDetail(background: this.background),
        LearningDetail(background: this.background),
      ][currentPageIndex],
    );
  }
}
