import 'package:flutter/material.dart';

class Bienvenida2Page extends StatelessWidget {
  const Bienvenida2Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido'),
        ),
        body: Container(
          decoration: BoxDecoration(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
