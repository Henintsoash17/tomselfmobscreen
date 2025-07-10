import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;
  bool _isLoading = true;
  Map<String, dynamic>? _user;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  Map<String, dynamic>? get user => _user;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      _isAuthenticated = await _authService.isLoggedIn();
      if (_isAuthenticated) {
        _user = await _authService.getUserData();
      }
    } catch (e) {
      _isAuthenticated = false;
      _user = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final result = await _authService.login(email, password);
      _isAuthenticated = true;
      _user = result['user'];
      notifyListeners();
      return true;
    } catch (e) {
      _isAuthenticated = false;
      _user = null;
      notifyListeners();
      rethrow;
    }
  }

  Future<bool> register(String email, String password, String name) async {
    try {
      final result = await _authService.register(email, password, name);
      _isAuthenticated = true;
      _user = result['user'];
      notifyListeners();
      return true;
    } catch (e) {
      _isAuthenticated = false;
      _user = null;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _isAuthenticated = false;
    _user = null;
    notifyListeners();
  }
}