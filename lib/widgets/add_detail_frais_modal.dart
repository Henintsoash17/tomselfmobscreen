// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';

class AddDetailFraisModal extends StatefulWidget {
  @override
  _AddDetailFraisModalState createState() => _AddDetailFraisModalState();
}

class _AddDetailFraisModalState extends State<AddDetailFraisModal> {
  final _formKey = GlobalKey<FormState>();
  final _rubriqueController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tiersController = TextEditingController();
  final _tiersAuxiliaireController = TextEditingController();
  final _montantLocalController = TextEditingController();

  @override
  void dispose() {
    _rubriqueController.dispose();
    _descriptionController.dispose();
    _tiersController.dispose();
    _tiersAuxiliaireController.dispose();
    _montantLocalController.dispose();
    super.dispose();
  }

  void _submitDetail() {
    if (_formKey.currentState!.validate()) {
      final detail = {
        'rubrique': _rubriqueController.text,
        'description': _descriptionController.text,
        'tiers': _tiersController.text,
        'tiersAuxiliaire': _tiersAuxiliaireController.text,
        'montantLocal': double.parse(_montantLocalController.text),
      };
      
      Navigator.pop(context, detail);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.9,
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
                'Ajouter un détail de frais',
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
                        // Rubrique
                        TextFormField(
                          controller: _rubriqueController,
                          decoration: InputDecoration(
                            labelText: 'Rubrique',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.category),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer la rubrique';
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
                        SizedBox(height: 16),
                        // Tiers
                        TextFormField(
                          controller: _tiersController,
                          decoration: InputDecoration(
                            labelText: 'Tiers',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.business),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer le tiers';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        // Tiers Auxiliaire
                        TextFormField(
                          controller: _tiersAuxiliaireController,
                          decoration: InputDecoration(
                            labelText: 'Tiers Auxiliaire',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.location_on),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer le tiers auxiliaire';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        // Montant local
                        TextFormField(
                          controller: _montantLocalController,
                          decoration: InputDecoration(
                            labelText: 'Montant local (€)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.euro),
                          ),
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer le montant';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Veuillez entrer un montant valide';
                            }
                            if (double.parse(value) <= 0) {
                              return 'Le montant doit être supérieur à 0';
                            }
                            return null;
                          },
                        ),
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
                      onPressed: _submitDetail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Ajouter',
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
