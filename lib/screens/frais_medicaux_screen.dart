// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import '../widgets/add_frais_medicaux_modal.dart';
import 'frais_medicaux_detail_screen.dart';

class FraisMedicauxScreen extends StatefulWidget {
  const FraisMedicauxScreen({super.key});

  @override
  _FraisMedicauxScreenState createState() => _FraisMedicauxScreenState();
}

class _FraisMedicauxScreenState extends State<FraisMedicauxScreen> {
  // Données fictives pour l'exemple
  final List<Map<String, dynamic>> fraisMedicaux = [
    {
      'id': 1,
      'nom': 'Jean Dupont',
      'libelle': 'Consultation généraliste',
      'refFacture': 'FAC-2024-001',
      'medecin': 'Dr. Martin',
      'typeTraitement': 'Consultation',
      'observation': 'Consultation de routine',
      'status': 'validé',
      'montantFacture': 25000.00,
      'montantDemande': 15000.00,
      'montantRembourse': 15000.00,
      'commentaire': 'Consultation générale pour contrôle de santé annuel',
    },
    {
      'id': 2,
      'nom': 'Marie Martin',
      'libelle': 'Radiographie thoracique',
      'refFacture': 'FAC-2024-002',
      'medecin': 'Dr. Dubois',
      'typeTraitement': 'Imagerie',
      'observation': 'Contrôle pulmonaire',
      'status': 'attente',
      'montantFacture': 45000.00,
      'montantDemande': 45000.00,
      'montantRembourse': 31500.00,
      'commentaire': 'Radiographie prescrite suite à toux persistante',
    },
    {
      'id': 3,
      'nom': 'Pierre Durand',
      'libelle': 'Soins dentaires',
      'refFacture': 'FAC-2024-003',
      'medecin': 'Dr. Leroy',
      'typeTraitement': 'Dentaire',
      'observation': 'Détartrage et soins',
      'status': 'validé',
      'montantFacture': 8000.00,
      'montantDemande': 8000.00,
      'montantRembourse': 5600.00,
      'commentaire': 'Soins dentaires de routine avec détartrage',
    },
    {
      'id': 4,
      'nom': 'Sophie Leblanc',
      'libelle': 'Analyse de sang',
      'refFacture': 'FAC-2024-004',
      'medecin': 'Laboratoire Central',
      'typeTraitement': 'Analyse',
      'observation': 'Bilan sanguin complet',
      'status': 'attente',
      'montantFacture': 35000.00,
      'montantDemande': 35000.00,
      'montantRembourse': 24500.00,
      'commentaire': 'Bilan sanguin prescrit pour suivi médical',
    },
    {
      'id': 5,
      'nom': 'Thomas Bernard',
      'libelle': 'Kinésithérapie',
      'refFacture': 'FAC-2024-005',
      'medecin': 'Cabinet Kiné Plus',
      'typeTraitement': 'Rééducation',
      'observation': 'Séances de rééducation',
      'status': 'validé',
      'montantFacture': 12000.00,
      'montantDemande': 12000.00,
      'montantRembourse': 8400.00,
      'commentaire': 'Séances de kinésithérapie pour rééducation du dos',
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'validé':
        return Colors.green;
      case 'attente':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _showAddFraisMedicauxModal() {
    showDialog(
      context: context,
      builder: (context) => AddFraisMedicauxModal(),
    );
  }

  void _navigateToDetail(Map<String, dynamic> frais) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FraisMedicauxDetailScreen(frais: frais),
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
          'Frais médicaux',
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
                itemCount: fraisMedicaux.length,
                itemBuilder: (context, index) {
                  final frais = fraisMedicaux[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: _getStatusColor(frais['status']),
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => _navigateToDetail(frais),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Nom de l'utilisateur et statut
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      frais['nom'],
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
                                      color: _getStatusColor(frais['status']).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: _getStatusColor(frais['status']),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      frais['status'].toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor(frais['status']),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              // Libellé
                              _buildInfoRow(Icons.medical_services, 'Libellé', frais['libelle']),
                              SizedBox(height: 8),
                              // Ref facture
                              _buildInfoRow(Icons.receipt, 'Réf. facture', frais['refFacture']),
                              SizedBox(height: 8),
                              // Médecin
                              _buildInfoRow(Icons.person, 'Médecin', frais['medecin']),
                              SizedBox(height: 8),
                              // Type de traitement
                              _buildInfoRow(Icons.healing, 'Type de traitement', frais['typeTraitement']),
                              SizedBox(height: 8),
                              // Observation
                              _buildInfoRow(Icons.note, 'Observation', frais['observation']),
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
        onPressed: _showAddFraisMedicauxModal,
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
