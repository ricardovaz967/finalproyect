import 'package:flutter/material.dart';
import 'package:prueba_firebase/pages/bienvenida2_pages.dart';
import 'package:prueba_firebase/pages/inicio_page.dart';
import 'package:prueba_firebase/pages/registro_pages.dart';

Map<String, WidgetBuilder> obtenerRutas() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => InicioPage(),
    'registro': (BuildContext context) => RegistroPage(),
    'bienvenida2': (BuildContext contex) => Bienvenida2Page()
  };
}
