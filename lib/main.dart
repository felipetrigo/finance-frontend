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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Column(children: [
        Expanded(child: Container(
            padding: const EdgeInsets.all(16),
            child: const Text("BEM VINDO", style: TextStyle(fontSize: 20)))),
        Expanded(child: Container(
          alignment: Alignment.topCenter,
          child: ElevatedButton(
            onPressed: () => entrar(context),
            child: const Text("ENTRAR", style: TextStyle(fontSize: 20)),
          ),
        ),)
      ])),
    ));
  }

  void entrar(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const NavigationExample()));
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Conta',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Casa',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'Aprender',
          ),
        ],
      ),
      body: <Widget>[
        AccountDetail(),
        HomeDetail(),
        LearningDetail(),
      ][currentPageIndex],
    );
  }
}
