// lib/data/auth_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  // URL base de la API
  static const String baseUrl = 'http://localhost:3000/api/users';
  
  // Para emulador Android:
  // static const String baseUrl = 'http://10.0.2.2:3000/api/users';
  
  // Para dispositivos físicos: 
  // static const String baseUrl = 'http://192.168.1.X:3000/api/users';
  
  // Clave para almacenar el token en SharedPreferences
  static const String tokenKey = 'auth_token';
  
  // Guardar token
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }
  
  // Obtener token almacenado
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }
  
  // Eliminar token (logout)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }
  
  // Verificar si hay token guardado
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null;
  }
  
  // Login de usuario
  Future<User> login(String email, String password) async {
    try {
      debugPrint('Intentando login con: $email');
      debugPrint('URL de login: ${Uri.parse('$baseUrl/login')}');
      
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      
      debugPrint('Código de estado: ${response.statusCode}');
      debugPrint('Respuesta login completa: ${response.body}');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        debugPrint('data[success]: ${data['success']}');
        
        if (data['success'] == true) {
          await _saveToken(data['data']['token']);
          
          debugPrint('Token guardado: ${data['data']['token']}');
          debugPrint('Data user: ${data['data']['user']}');
          
          if (data['data']['user'] == null) {
            throw Exception('La respuesta no contiene datos de usuario');
          }
          
          return User.fromJson(data['data']['user']);
        } else {
          throw Exception(data['message'] ?? 'Error durante el inicio de sesión');
        }
      } else {
        Map<String, dynamic> error;
        try {
          error = json.decode(response.body);
        } catch (e) {
          throw Exception('Error en la respuesta: ${response.body}');
        }
        throw Exception(error['message'] ?? 'Error durante el inicio de sesión');
      }
    } catch (e) {
      debugPrint('Error en login: $e');
      rethrow;
    }
  }
  
  // Registro de usuario
  Future<User> register(String username, String email, String password) async {
    try {
      debugPrint('Intentando registro con: $email, $username');
      debugPrint('URL de registro: ${Uri.parse('$baseUrl/register')}');
      
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );
      
      debugPrint('Código de estado: ${response.statusCode}');
      debugPrint('Respuesta register completa: ${response.body}');
      
      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        if (data['success'] == true) {
          await _saveToken(data['data']['token']);
          
          debugPrint('Token guardado: ${data['data']['token']}');
          debugPrint('Data user: ${data['data']['user']}');
          
          if (data['data']['user'] == null) {
            throw Exception('La respuesta no contiene datos de usuario');
          }
          
          return User.fromJson(data['data']['user']);
        } else {
          throw Exception(data['message'] ?? 'Error durante el registro');
        }
      } else {
        Map<String, dynamic> error;
        try {
          error = json.decode(response.body);
        } catch (e) {
          throw Exception('Error en la respuesta: ${response.body}');
        }
        throw Exception(error['message'] ?? 'Error durante el registro');
      }
    } catch (e) {
      debugPrint('Error en register: $e');
      rethrow;
    }
  }
  
  // Obtener perfil de usuario
  Future<User> getProfile() async {
    try {
      final token = await getToken();
      
      if (token == null) {
        throw Exception('No hay sesión activa');
      }
      
      debugPrint('Obteniendo perfil con token: $token');
      debugPrint('URL de perfil: ${Uri.parse('$baseUrl/profile')}');
      
      final response = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      
      debugPrint('Código de estado: ${response.statusCode}');
      debugPrint('Respuesta profile completa: ${response.body}');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        if (data['success'] == true) {
          debugPrint('Data profile: ${data['data']}');
          return User.fromJson(data['data']);
        } else {
          throw Exception(data['message'] ?? 'Error al obtener el perfil');
        }
      } else {
        Map<String, dynamic> error;
        try {
          error = json.decode(response.body);
        } catch (e) {
          throw Exception('Error en la respuesta: ${response.body}');
        }
        throw Exception(error['message'] ?? 'Error al obtener el perfil');
      }
    } catch (e) {
      debugPrint('Error en getProfile: $e');
      rethrow;
    }
  }
}