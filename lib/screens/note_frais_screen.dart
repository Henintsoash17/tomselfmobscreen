// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import '../widgets/add_note_frais_modal.dart';
import 'note_frais_detail_screen.dart';

class NoteFraisScreen extends StatefulWidget {
  const NoteFraisScreen({super.key});

  @override
  _NoteFraisScreenState createState() => _NoteFraisScreenState();
}

class _NoteFraisScreenState extends State<NoteFraisScreen> {
  // Données fictives pour l'exemple
  final List<Map<String, dynamic>> notesFrais = [
    {
      'id': 1,
      'nomUser': 'Jean Dupont',
      'numeroDemande': 'NF-2024-001',
      'refFacture': 'FAC-001-2024',
      'description': 'Frais de déplacement mission Paris',
      'status': 'validé',
      'details': [
        {
          'rubrique': 'Transport',
          'description': 'Billet de train Paris-Lyon',
          'tiers': 'SNCF',
          'tiersAuxiliaire': 'Gare de Lyon',
          'montantLocal': 85.50,
        },
        {
          'rubrique': 'Hébergement',
          'description': 'Hôtel 2 nuits',
          'tiers': 'Hôtel Mercure',
          'tiersAuxiliaire': 'Paris Centre',
          'montantLocal': 240.00,
        },
      ],
    },
    {
      'id': 2,
      'nomUser': 'Marie Martin',
      'numeroDemande': 'NF-2024-002',
      'refFacture': 'FAC-002-2024',
      'description': 'Frais de repas client',
      'status': 'attente',
      'details': [
        {
          'rubrique': 'Restauration',
          'description': 'Déjeuner d\'affaires',
          'tiers': 'Restaurant Le Gourmet',
          'tiersAuxiliaire': 'Lyon Centre',
          'montantLocal': 125.00,
        },
      ],
    },
    {
      'id': 3,
      'nomUser': 'Pierre Durand',
      'numeroDemande': 'NF-2024-003',
      'refFacture': 'FAC-003-2024',
      'description': 'Matériel de bureau',
      'status': 'refusé',
      'details': [
        {
          'rubrique': 'Fournitures',
          'description': 'Ordinateur portable',
          'tiers': 'Tech Store',
          'tiersAuxiliaire': 'Magasin Lyon',
          'montantLocal': 899.99,
        },
      ],
    },
    {
      'id': 4,
      'nomUser': 'Sophie Leblanc',
      'numeroDemande': 'NF-2024-004',
      'refFacture': 'FAC-004-2024',
      'description': 'Formation professionnelle',
      'status': 'à justifier',
      'details': [
        {
          'rubrique': 'Formation',
          'description': 'Stage de perfectionnement',
          'tiers': 'Centre de Formation Pro',
          'tiersAuxiliaire': 'Marseille',
          'montantLocal': 450.00,
        },
      ],
    },
    {
      'id': 5,
      'nomUser': 'Thomas Bernard',
      'numeroDemande': 'NF-2024-005',
      'refFacture': 'FAC-005-2024',
      'description': 'Frais de communication',
      'status': 'validé',
      'details': [
        {
          'rubrique': 'Télécom',
          'description': 'Forfait mobile professionnel',
          'tiers': 'Orange Business',
          'tiersAuxiliaire': 'Agence Lyon',
          'montantLocal': 89.90,
        },
      ],
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
      case 'à justifier':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  void _showAddNoteFraisModal() {
    showDialog(
      context: context,
      builder: (context) => AddNoteFraisModal(),
    );
  }

  void _navigateToDetail(Map<String, dynamic> noteFrais) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteFraisDetailScreen(noteFrais: noteFrais),
      ),
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
          'Notes de frais',
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
                itemCount: notesFrais.length,
                itemBuilder: (context, index) {
                  final noteFrais = notesFrais[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: _getStatusColor(noteFrais['status']),
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => _navigateToDetail(noteFrais),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Nom utilisateur et statut
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      noteFrais['nomUser'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
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
                              SizedBox(height: 12),
                              // Numéro de demande
                              _buildInfoRow(Icons.confirmation_number, 'Numéro demande', noteFrais['numeroDemande']),
                              SizedBox(height: 8),
                              // Ref facture
                              _buildInfoRow(Icons.receipt, 'Réf. facture', noteFrais['refFacture']),
                              SizedBox(height: 8),
                              // Description
                              _buildInfoRow(Icons.description, 'Description', noteFrais['description']),
                            ],
                          ),
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
        onPressed: _showAddNoteFraisModal,
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
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
    );
  }
}