// ignore_for_file: avoid_print, deprecated_member_use, library_private_types_in_public_api, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';

class AddFraisMedicauxModal extends StatefulWidget {
  const AddFraisMedicauxModal({super.key});

  @override
  _AddFraisMedicauxModalState createState() => _AddFraisMedicauxModalState();
}

class _AddFraisMedicauxModalState extends State<AddFraisMedicauxModal> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _libelleController = TextEditingController();
  final _refFactureController = TextEditingController();
  final _medecinController = TextEditingController();
  final _observationController = TextEditingController();

  // Liste des traitements
  final List<Map<String, dynamic>> _traitements = [];

  @override
  void dispose() {
    _nomController.dispose();
    _libelleController.dispose();
    _refFactureController.dispose();
    _medecinController.dispose();
    _observationController.dispose();
    super.dispose();
  }

  void _addTraitement() {
    showDialog(
      context: context,
      builder: (context) => _TraitementDialog(
        onAdd: (traitement) {
          setState(() {
            _traitements.add(traitement);
          });
        },
      ),
    );
  }

  void _removeTraitement(int index) {
    setState(() {
      _traitements.removeAt(index);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_traitements.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Veuillez ajouter au moins un traitement'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Ici vous ajouteriez la logique pour sauvegarder la demande
      print('Nouvelle demande de frais médicaux:');
      print('Nom: ${_nomController.text}');
      print('Libellé: ${_libelleController.text}');
      print('Réf. facture: ${_refFactureController.text}');
      print('Médecin: ${_medecinController.text}');
      print('Observation: ${_observationController.text}');
      print('Traitements: $_traitements');
      
      Navigator.pop(context);
      
      // Afficher un message de confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Demande de frais médicaux soumise avec succès'),
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
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Titre
            Text(
              'Nouvelle demande de frais médicaux',
              style: TextStyle(
                fontSize: 20,
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
                      // Nom
                      TextFormField(
                        controller: _nomController,
                        decoration: InputDecoration(
                          labelText: 'Nom',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le nom';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Libellé
                      TextFormField(
                        controller: _libelleController,
                        decoration: InputDecoration(
                          labelText: 'Libellé',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.medical_services),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le libellé';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Réf facture
                      TextFormField(
                        controller: _refFactureController,
                        decoration: InputDecoration(
                          labelText: 'Référence facture',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.receipt),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer la référence facture';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Médecin
                      TextFormField(
                        controller: _medecinController,
                        decoration: InputDecoration(
                          labelText: 'Médecin',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.local_hospital),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le nom du médecin';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Observation
                      TextFormField(
                        controller: _observationController,
                        decoration: InputDecoration(
                          labelText: 'Observation',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.note),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer une observation';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      // Section des traitements
                      Row(
                        children: [
                          Text(
                            'Traitements',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Spacer(),
                          ElevatedButton.icon(
                            onPressed: _addTraitement,
                            icon: Icon(Icons.add, size: 18),
                            label: Text('Ajouter'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      // Liste des traitements
                      ..._traitements.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> traitement = entry.value;
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
                                        traitement['type'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => _removeTraitement(index),
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      constraints: BoxConstraints(),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text('Montant facturé: ${traitement['montantFacture']} €'),
                                Text('Montant demandé: ${traitement['montantDemande']} €'),
                                Text('Montant remboursé: ${traitement['montantRembourse']} €'),
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
    );
  }
}

class _TraitementDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onAdd;

  const _TraitementDialog({required this.onAdd});

  @override
  _TraitementDialogState createState() => _TraitementDialogState();
}

class _TraitementDialogState extends State<_TraitementDialog> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _montantFactureController = TextEditingController();
  final _montantDemandeController = TextEditingController();
  final _montantRembourseController = TextEditingController();

  @override
  void dispose() {
    _typeController.dispose();
    _montantFactureController.dispose();
    _montantDemandeController.dispose();
    _montantRembourseController.dispose();
    super.dispose();
  }

  void _submitTraitement() {
    if (_formKey.currentState!.validate()) {
      widget.onAdd({
        'type': _typeController.text,
        'montantFacture': double.parse(_montantFactureController.text),
        'montantDemande': double.parse(_montantDemandeController.text),
        'montantRembourse': double.parse(_montantRembourseController.text),
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ajouter un traitement',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(
                  labelText: 'Type de traitement',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le type de traitement';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _montantFactureController,
                decoration: InputDecoration(
                  labelText: 'Montant facturé ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le montant facturé';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un montant valide';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _montantDemandeController,
                decoration: InputDecoration(
                  labelText: 'Montant demandé ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le montant demandé';
                  }                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un montant valide';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _montantRembourseController,
                decoration: InputDecoration(
                  labelText: 'Montant remboursé ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le montant remboursé';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un montant valide';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Annuler'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitTraitement,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Ajouter'),
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
