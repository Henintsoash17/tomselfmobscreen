// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import '../widgets/add_absence_modal.dart';

class AbsenceScreen extends StatefulWidget {
  const AbsenceScreen({super.key});

  @override
  _AbsenceScreenState createState() => _AbsenceScreenState();
}

class _AbsenceScreenState extends State<AbsenceScreen> {
  // Données fictives pour l'exemple
  final List<Map<String, dynamic>> absences = [
    {
      'userName': 'Jean Dupont',
      'startDate': '15/03/2024',
      'endDate': '20/03/2024',
      'days': 6,
      'status': 'validé', // validé, attente, refusé
    },
    {
      'userName': 'Marie Martin',
      'startDate': '22/03/2024',
      'endDate': '25/03/2024',
      'days': 4,
      'status': 'attente',
    },
    {
      'userName': 'Pierre Durand',
      'startDate': '01/04/2024',
      'endDate': '05/04/2024',
      'days': 5,
      'status': 'refusé',
    },
    {
      'userName': 'Sophie Leblanc',
      'startDate': '10/04/2024',
      'endDate': '12/04/2024',
      'days': 3,
      'status': 'validé',
    },
    {
      'userName': 'Thomas Bernard',
      'startDate': '15/04/2024',
      'endDate': '18/04/2024',
      'days': 4,
      'status': 'attente',
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'validé':
        return Colors.green;
      case 'attente':
        return Colors.orange;
      case 'refusé':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showAddAbsenceModal() {
    showDialog(
      context: context,
      builder: (context) => AddAbsenceModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Absences',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: absences.length,
                itemBuilder: (context, index) {
                  final absence = absences[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: _getStatusColor(absence['status']),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nom de l'utilisateur
                            Text(
                              absence['userName'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8),
                            // Dates
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Du ${absence['startDate']} au ${absence['endDate']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            // Nombre de jours
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '${absence['days']} jour${absence['days'] > 1 ? 's' : ''}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Spacer(),
                                // Statut
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(absence['status']).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: _getStatusColor(absence['status']),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    absence['status'].toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: _getStatusColor(absence['status']),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAbsenceModal,
        backgroundColor: Colors.red,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
