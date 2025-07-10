import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;
  HttpService._internal();

  final http.Client _client = http.Client();
  String? _authToken;

  // Headers par défaut
  Map<String, String> get _defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (_authToken != null) 'Authorization': 'Bearer $_authToken',
  };

  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  Future<http.Response> get(String endpoint) async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      print('GET: $url'); // Pour debug
      
      final response = await _client.get(
        url,
        headers: _defaultHeaders,
      ).timeout(const Duration(seconds: 30));
      
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<http.Response> post(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      print('POST: $url'); // Pour debug
      
      final response = await _client.post(
        url,
        headers: _defaultHeaders,
        body: body != null ? jsonEncode(body) : null,
      ).timeout(const Duration(seconds: 30));
      
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<http.Response> put(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      print('PUT: $url'); // Pour debug
      
      final response = await _client.put(
        url,
        headers: _defaultHeaders,
        body: body != null ? jsonEncode(body) : null,
      ).timeout(const Duration(seconds: 30));
      
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<http.Response> delete(String endpoint) async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      print('DELETE: $url'); // Pour debug
      
      final response = await _client.delete(
        url,
        headers: _defaultHeaders,
      ).timeout(const Duration(seconds: 30));
      
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  http.Response _handleResponse(http.Response response) {
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');
    
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw HttpException(
        'HTTP Error ${response.statusCode}: ${response.reasonPhrase}',
        uri: response.request?.url,
      );
    }
  }

  Exception _handleError(dynamic error) {
    if (error is SocketException) {
      return Exception('Erreur de connexion: Vérifiez que le serveur est démarré sur ${ApiConfig.baseUrl}');
    } else if (error is HttpException) {
      return error;
    } else {
      return Exception('Erreur inattendue: $error');
    }
  }

  void dispose() {
    _client.close();
  }
}