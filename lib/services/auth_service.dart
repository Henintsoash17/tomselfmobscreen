import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'http_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final HttpService _httpService = HttpService();
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _httpService.post('/api/tomself/sessionself/SigninSelf', body: {
        'email': email,
        'password': password,
      });

      final data = jsonDecode(response.body);
      
      if (data['token'] != null) {
        await _saveToken(data['token']);
        await _saveUserData(data['user']);
        _httpService.setAuthToken(data['token']);
      }

      return data;
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  Future<Map<String, dynamic>> register(String email, String password, String name) async {
    try {
      final response = await _httpService.post('/api/auth/register', body: {
        'email': email,
        'password': password,
        'name': name,
      });

      final data = jsonDecode(response.body);
      
      if (data['token'] != null) {
        await _saveToken(data['token']);
        await _saveUserData(data['user']);
        _httpService.setAuthToken(data['token']);
      }

      return data;
    } catch (e) {
      throw Exception('Erreur d\'inscription: $e');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
    _httpService.clearAuthToken();
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    if (token != null) {
      _httpService.setAuthToken(token);
      return true;
    }
    return false;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    return userData != null ? jsonDecode(userData) : null;
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<void> _saveUserData(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user));
  }
}