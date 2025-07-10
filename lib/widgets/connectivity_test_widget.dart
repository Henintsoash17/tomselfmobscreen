import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ConnectivityTestWidget extends StatefulWidget {
  const ConnectivityTestWidget({super.key});

  @override
  State<ConnectivityTestWidget> createState() => _ConnectivityTestWidgetState();
}

class _ConnectivityTestWidgetState extends State<ConnectivityTestWidget> {
  Map<String, dynamic>? _testResults;
  bool _isTesting = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: const Text('Test de connectivité'),
        leading: const Icon(Icons.network_check),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _isTesting ? null : _testConnectivity,
                  child: _isTesting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Tester les connexions'),
                ),
                const SizedBox(height: 16),
                if (_testResults != null) ...[
                  const Text(
                    'Résultats:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ..._testResults!.entries.map((entry) {
                    final result = entry.value as Map<String, dynamic>;
                    final isAccessible = result['accessible'] as bool;
                    
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isAccessible ? Icons.check_circle : Icons.error,
                                color: isAccessible ? Colors.green : Colors.red,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${entry.key}',
                                  style: TextStyle(
                                    color: isAccessible ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Text(
                              'Status: ${result['status']}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          if (result['error'] != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Text(
                                'Erreur: ${result['error']}',
                                style: const TextStyle(fontSize: 12, color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _testConnectivity() async {
    setState(() {
      _isTesting = true;
      _testResults = null;
    });

    final results = <String, dynamic>{};
    
    // Test des différentes URLs
    final urlsToTest = [
      'Base URL: ${ApiConfig.baseUrl}',
      'SigninSelf: ${ApiConfig.baseUrl}/api/tomself/sessionself/SigninSelf',
      'Users: ${ApiConfig.baseUrl}/api/tomself/sessionself/Users',
      'Test simple: ${ApiConfig.baseUrl}/api/tomself/sessionself/Test',
    ];
    
    for (final urlTest in urlsToTest) {
      final parts = urlTest.split(': ');
      final name = parts[0];
      final url = parts[1];
      
      try {
        final response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ).timeout(const Duration(seconds: 10));
        
        results[name] = {
          'status': response.statusCode,
          'accessible': response.statusCode < 500, // Même 404 est mieux que 500
          'body': response.body.length > 200 
              ? '${response.body.substring(0, 200)}...' 
              : response.body,
        };
        
      } catch (e) {
        results[name] = {
          'status': 'Erreur de connexion',
          'accessible': false,
          'error': e.toString(),
        };
      }
    }
    
    setState(() {
      _testResults = results;
      _isTesting = false;
    });
  }
}