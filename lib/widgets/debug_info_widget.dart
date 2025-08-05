import 'package:flutter/material.dart';
import '../config/api_config.dart';

class DebugInfoWidget extends StatelessWidget {
  const DebugInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final debugInfo = ApiConfig.getDebugInfo();
    
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: const Text('Debug Info'),
        leading: const Icon(Icons.bug_report),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: debugInfo.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          '${entry.key}:',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: TextStyle(
                            color: entry.key == 'baseUrl' 
                                ? Colors.blue 
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}