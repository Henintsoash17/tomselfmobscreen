// ignore_for_file: avoid_print, deprecated_member_use, unused_field, library_private_types_in_public_api, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'add_detail_frais_modal.dart';

class AddNoteFraisModal extends StatefulWidget {
  const AddNoteFraisModal({super.key});

  @override
  _AddNoteFraisModalState createState() => _AddNoteFraisModalState();
}

class _AddNoteFraisModalState extends State<AddNoteFraisModal> {
  final _formKey = GlobalKey<FormState>();
  final _anneeController = TextEditingController();
  final _numeroDemandeController = TextEditingController();
  final _refMissionController = TextEditingController();
  final _refFactureController = TextEditingController();
  final _dateDemandeController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _dateDemande;
  final List<Map<String, dynamic>> _detailsFrais = [];

  @override
  void initState() {
    super.initState();
    // Initialiser l'année avec l'année courante
    _anneeController.text = DateTime.now().year.toString();
  }

  @override
  void dispose() {
    _anneeController.dispose();
    _numeroDemandeController.dispose();
    _refMissionController.dispose();
    _refFactureController.dispose();
    _dateDemandeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    
    if (picked != null) {
      setState(() {
        _dateDemande = picked;
        _dateDemandeController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _showAddDetailModal() {
    showDialog(
      context: context,
      builder: (context) => AddDetailFraisModal(),
    ).then((result) {
      if (result != null) {
        setState(() {
          _detailsFrais.add(result);
        });
      }
    });
  }

  void _removeDetail(int index) {
    setState(() {
      _detailsFrais.removeAt(index);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_detailsFrais.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Veuillez ajouter au moins un détail de frais'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // Ici vous ajouteriez la logique pour sauvegarder la note de frais
      print('Nouvelle note de frais:');
      print('Année: ${_anneeController.text}');
      print('Numéro demande: ${_numeroDemandeController.text}');
      print('Réf mission: ${_refMissionController.text}');
      print('Réf facture: ${_refFactureController.text}');
      print('Date demande: ${_dateDemandeController.text}');
      print('Description: ${_descriptionController.text}');
      print('Détails: $_detailsFrais');
      
      Navigator.pop(context);
      
      // Afficher un message de confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Note de frais soumise avec succès'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Titre
              Text(
                'Nouvelle note de frais',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Formulaire
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Année
                        TextFormField(
                          controller: _anneeController,
                          decoration: InputDecoration(
                            labelText: 'Année',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer l\'année';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        // Numéro demande
                        TextFormField(
                          controller: _numeroDemandeController,
                          decoration: InputDecoration(
                            labelText: 'Numéro demande',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.confirmation_number),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer le numéro de demande';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        // Ref mission
                        TextFormField(
                          controller: _refMissionController,
                          decoration: InputDecoration(
                            labelText: 'Réf mission',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.business_center),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer la référence de mission';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        // Ref facture
                        TextFormField(
                          controller: _refFactureController,
                          decoration: InputDecoration(
                            labelText: 'Réf facture',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.receipt),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer la référence de facture';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        // Date de demande
                        TextFormField(
                          controller: _dateDemandeController,
                          decoration: InputDecoration(
                            labelText: 'Date de demande (dd/mm/yyyy)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.calendar_today),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                          ),
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez sélectionner une date';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        // Description
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.description),
                            alignLabelWithHint: true,
                          ),
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer une description';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // Section détails des frais
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Détails des frais',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: _showAddDetailModal,
                              icon: Icon(Icons.add, color: Colors.white),
                              label: Text(
                                'Ajouter',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        // Liste des détails ajoutés
                        ..._detailsFrais.asMap().entries.map((entry) {
                          int index = entry.key;
                          Map<String, dynamic> detail = entry.value;
                          return Card(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          detail['rubrique'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => _removeDetail(index),
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        constraints: BoxConstraints(),
                                        padding: EdgeInsets.zero,
                                      ),
                                    ],
                                  ),
                                  Text('${detail['description']}'),
                                  Text('Tiers: ${detail['tiers']}'),
                                  Text('Montant: ${detail['montantLocal'].toStringAsFixed(2)} €'),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Boutons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Annuler',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Soumettre',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
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
  }
}