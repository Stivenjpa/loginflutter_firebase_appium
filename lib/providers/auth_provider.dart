import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Verifica sí el usuario actual existe
  User? get currentUser => _auth.currentUser;

  //Funcion para iniciar sesion con email y contraseña
  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      //Autenticacion con firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      //Error de Firebase se muestra en pantalla
      throw e;
    } catch (e) {
      throw Exception('Ocurrio un error en la autenticacion');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
