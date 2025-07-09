// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';

class NoteFraisDetailScreen extends StatelessWidget {
  final Map<String, dynamic> noteFrais;

  const NoteFraisDetailScreen({super.key, required this.noteFrais});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'validé':
        return Colors.green;
      case 'attente':
        return Colors.orange;
      case 'refusé':
        return Colors.red;
      case 'à justifier':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> details = noteFrais['details'] ?? [];
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Détail note de frais',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carte principale avec informations de base
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: _getStatusColor(noteFrais['status']),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nom et statut
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              noteFrais['nomUser'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(noteFrais['status']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _getStatusColor(noteFrais['status']),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              noteFrais['status'].toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor(noteFrais['status']),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Informations de base
                      _buildDetailRow('Numéro demande', noteFrais['numeroDemande']),
                      _buildDetailRow('Réf. facture', noteFrais['refFacture']),
                      _buildDetailRow('Description', noteFrais['description']),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Section des détails
              Text(
                'Détails des frais',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12),
              // Liste des détails
              ...details.map((detail) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
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
                        _buildDetailRow('Rubrique', detail['rubrique']),
                        _buildDetailRow('Description', detail['description']),
                        _buildDetailRow('Tiers', detail['tiers']),
                        _buildDetailRow('Tiers Auxiliaire', detail['tiersAuxiliaire']),
                        _buildDetailRow('Montant local', '${detail['montantLocal'].toStringAsFixed(2)} €'),
                      ],
                    ),
                  ),
                ),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
