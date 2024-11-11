import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Learning.dart';


class LearningDescription extends StatelessWidget {
  LearningDescription(this.backgroundColor ,this.it, {super.key});
  final Learning it;
  Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Column(children: [Text(it.title,style: const TextStyle(
            fontSize: 34,
            color: Colors.white
        ),softWrap: true), Text("Por ${it.author}",style: const TextStyle(
            fontSize: 12,
            color: Colors.white
        ), softWrap: true)]),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [Padding(padding: EdgeInsets.all(8), child: Text(it.text,style: TextStyle(color: Colors.white),))],
        ),
      ),
    );
  }
}