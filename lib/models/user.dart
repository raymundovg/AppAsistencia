// lib/models/user.dart
import 'package:flutter/foundation.dart';

class User {
  final String uid;
  final String username;
  final String email;
  final int roleId;

  User({
    required this.uid,
    required this.username,
    required this.email,
    required this.roleId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Imprimir el JSON para depuración
    debugPrint('User.fromJson recibió: $json');
    
    // Intenta obtener rol de diferentes maneras posibles
    var rolValue;
    
    if (json.containsKey('role_id')) {
      rolValue = json['role_id'];
    } else if (json.containsKey('rol')) {
      rolValue = json['rol'];
    } else {
      // Si no hay rol, usa 3 como valor predeterminado (usuario regular)
      debugPrint('⚠️ No se encontró ni "rol" ni "role_id" en el JSON');
      rolValue = 3;  // Valor predeterminado: usuario regular
    }
    
    // Convertir a entero en caso de que venga como string
    final int roleId = rolValue is String 
      ? int.parse(rolValue) 
      : (rolValue is int ? rolValue : 3);
    
    // Asegurarse de que uid sea string
    final String uidStr = json['uid'].toString();
    
    return User(
      uid: uidStr,
      username: json['username'],
      email: json['email'],
      roleId: roleId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'rol': roleId,  // Usar 'rol' para mantener consistencia con la API
    };
  }

  bool get isAdmin => roleId == 1;
  bool get isVet => roleId == 2;
  bool get isRegularUser => roleId == 3;
}