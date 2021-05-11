import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistroPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<RegistroPage> {
  final firebaseInstance = FirebaseFirestore.instance;

  FocusNode nombreFocus;
  FocusNode emailFocus;
  FocusNode contraFocus;

  String nombre;
  String email;
  String contra;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(),
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                ),
                Text(
                  '¡Unete',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 60,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'a nosotros!',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 60,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Nombre y Apellido',
                      hintText: 'Ejemplo:Juan Perez',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      )),
                  onSaved: (value) {
                    nombre = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo vacío';
                    } else {
                      return null;
                    }
                  },
                  focusNode: this.nombreFocus,
                  onEditingComplete: () => requestFocus(context, emailFocus),
                  textInputAction: TextInputAction.next,
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
                    email = value;
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
                        labelStyle: TextStyle(color: Colors.black),
                        labelText: 'Contraseña',
                        hintText: 'Mínimo 8 caracteres',
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
                      child: Text('Registrar'),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          firebaseInstance.collection('usuarios').add({
                            'nombre': nombre,
                            'correo': email,
                            'con': contra
                          });
                          Navigator.pushNamed(
                            context,
                            '/',
                          );
                        }
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
