// lib/data/auth_provider.dart
import 'package:flutter/foundation.dart';
import '../models/user.dart';
import 'auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  
  User? _currentUser;
  bool _isLoading = false;
  String? _error;
  
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _currentUser != null;
  
  // Verificar estado de autenticación
  Future<bool> checkAuth() async {
    try {
      final isAuth = await _authService.isAuthenticated();
      
      if (isAuth) {
        _isLoading = true;
        notifyListeners();
        
        try {
          _currentUser = await _authService.getProfile();
        } catch (e) {
          // Si hay error al obtener perfil, limpiar token
          await _authService.logout();
          _error = e.toString();
          _isLoading = false;
          notifyListeners();
          return false;
        }
      }
      
      _isLoading = false;
      notifyListeners();
      return isAuth;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  // Iniciar sesión
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _currentUser = await _authService.login(email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  // Registrar nuevo usuario
  Future<bool> register(String username, String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _currentUser = await _authService.register(username, email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  // Cerrar sesión
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    
    await _authService.logout();
    _currentUser = null;
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Limpiar mensaje de error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}