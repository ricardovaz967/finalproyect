import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prueba_firebase/models/user_model.dart';

class InicioPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<InicioPage> {
  bool show = true, showSpinner = false;
  String corre, contra, validCredentials = "";
  int res;

  void passwordVisibility() {
    setState(() {
      show = !show;
    });
  }

  FocusNode nombreFocus;
  FocusNode emailFocus;
  FocusNode contraFocus;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(),
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                ),
                Text(
                  '¡Tacos',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 60,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Go!',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 60,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'Inicia sesión',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 50, color: Colors.black),
                ),
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Email',
                      hintText: 'Ejemplo:alguien@gmail.com',
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: Colors.black,
                      )),
                  onSaved: (value) {
                    corre = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'campo vacio';
                    } else {
                      return null;
                    }
                  },
                  focusNode: this.emailFocus,
                  onEditingComplete: () => requestFocus(context, contraFocus),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                    decoration: InputDecoration(
                        suffix: InkWell(
                          child: Icon(
                            Icons.visibility,
                            color: Colors.teal,
                          ),
                          onTap: passwordVisibility,
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        labelText: 'Contraseña',
                        hintText: 'Ejemplo:mínimo 8 caracteres',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        )),
                    onSaved: (value) {
                      contra = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'campo vacio';
                      } else {
                        return null;
                      }
                    },
                    focusNode: this.contraFocus),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  width: 250.0,
                  height: 50.0,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Colors.cyan,
                      textColor: Colors.black,
                      child: Text('Inicia Sesión'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Future<void> _datosUser() async {
                            CollectionReference crUsuario = FirebaseFirestore
                                .instance
                                .collection("usuario");
                            QuerySnapshot usuarios = await crUsuario.get();
                            for (var doc in usuarios.docs) {
                              UserLogin(
                                  email: doc['correo'],
                                  pass: doc['contraseña']);
                            }
                          }

                          var user = UserLogin();
                          if (corre == user.email && contra == user.pass) {
                            Navigator.pushNamed(
                              context,
                              'bienvenida2',
                            );
                          } else {
                            print('Error');
                          }
                        }
                      }),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 250.0,
                  height: 50.0,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Colors.cyan,
                      textColor: Colors.black,
                      child: Text('Registrate'),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          'registro',
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  void initState() {
    super.initState();
    nombreFocus = FocusNode();
    emailFocus = FocusNode();
    contraFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    nombreFocus.dispose();
    emailFocus.dispose();
    contraFocus.dispose();
  }
}

class Argumentos {
  String nombre;
  String email;
  String contra;

  Argumentos({this.nombre, this.email, this.contra});
}
