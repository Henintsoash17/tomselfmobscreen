// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class BulletinScreen extends StatefulWidget {
  const BulletinScreen({super.key});

  @override
  _BulletinScreenState createState() => _BulletinScreenState();
}

class _BulletinScreenState extends State<BulletinScreen> {
  // Données fictives pour l'exemple
  final List<Map<String, dynamic>> bulletins = [
    {
      'mois': 'Janvier 2024',
      'indice': '450',
      'contrat': 'CDI - Temps plein',
      'dateDisponibilite': '05/02/2024',
    },
    {
      'mois': 'Décembre 2023',
      'indice': '445',
      'contrat': 'CDI - Temps plein',
      'dateDisponibilite': '05/01/2024',
    },
    {
      'mois': 'Novembre 2023',
      'indice': '440',
      'contrat': 'CDI - Temps plein',
      'dateDisponibilite': '05/12/2023',
    },
    {
      'mois': 'Octobre 2023',
      'indice': '435',
      'contrat': 'CDI - Temps plein',
      'dateDisponibilite': '05/11/2023',
    },
    {
      'mois': 'Septembre 2023',
      'indice': '430',
      'contrat': 'CDI - Temps plein',
      'dateDisponibilite': '05/10/2023',
    },
    {
      'mois': 'Août 2023',
      'indice': '425',
      'contrat': 'CDI - Temps plein',
      'dateDisponibilite': '05/09/2023',
    },
  ];

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
          'Bulletin de salaire',
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
                itemCount: bulletins.length,
                itemBuilder: (context, index) {
                  final bulletin = bulletins[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Mois du salaire
                            Text(
                              bulletin['mois'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 12),
                            // Row avec les informations
                            Row(
                              children: [
                                // Indice
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Indice',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        bulletin['indice'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Contrat
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Contrat',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        bulletin['contrat'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Date de disponibilité
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Disponible le',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        bulletin['dateDisponibilite'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            // Bouton de téléchargement
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Logique de téléchargement
                                  print('Téléchargement du bulletin ${bulletin['mois']}');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Téléchargement du bulletin ${bulletin['mois']}'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                icon: Icon(Icons.download, size: 18),
                                label: Text('Télécharger'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                ),
                              ),
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
    );
  }
}