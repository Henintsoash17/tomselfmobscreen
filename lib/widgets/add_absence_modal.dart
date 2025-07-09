// ignore_for_file: avoid_print, deprecated_member_use, unused_field

import 'package:flutter/material.dart';

class AddAbsenceModal extends StatefulWidget {
  const AddAbsenceModal({super.key});

  @override
  _AddAbsenceModalState createState() => _AddAbsenceModalState();
}

class _AddAbsenceModalState extends State<AddAbsenceModal> {
  final _formKey = GlobalKey<FormState>();
  final _contractController = TextEditingController();
  final _typeController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  @override
  void dispose() {
    _contractController.dispose();
    _typeController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          _startDateController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
        } else {
          _endDate = picked;
          _endDateController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
          _startTimeController.text = "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
        } else {
          _endTime = picked;
          _endTimeController.text = "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
        }
      });
    }
  }

  int _calculateDays() {
    if (_startDate != null && _endDate != null) {
      return _endDate!.difference(_startDate!).inDays + 1;
    }
    return 0;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Ici vous ajouteriez la logique pour sauvegarder la demande
      print('Nouvelle demande d\'absence:');
      print('Contrat: ${_contractController.text}');
      print('Type: ${_typeController.text}');
      print('Date début: ${_startDateController.text}');
      print('Date fin: ${_endDateController.text}');
      print('Heure début: ${_startTimeController.text}');
      print('Heure fin: ${_endTimeController.text}');
      print('Description: ${_descriptionController.text}');
      print('Nombre de jours: ${_calculateDays()}');
      
      Navigator.pop(context);
      
      // Afficher un message de confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Demande d\'absence soumise avec succès'),
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
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Titre
            Text(
              'Nouvelle demande d\'absence',
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
                      // Contrat
                      TextFormField(
                        controller: _contractController,
                        decoration: InputDecoration(
                          labelText: 'Contrat',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.work),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le contrat';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Type
                      TextFormField(
                        controller: _typeController,
                        decoration: InputDecoration(
                          labelText: 'Type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.category),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le type';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Date de début
                      TextFormField(
                        controller: _startDateController,
                        decoration: InputDecoration(
                          labelText: 'Début du congé (dd/mm/yyyy)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.calendar_today),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez sélectionner une date de début';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Date de fin
                      TextFormField(
                        controller: _endDateController,
                        decoration: InputDecoration(
                          labelText: 'Fin du congé (dd/mm/yyyy)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.calendar_today),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, false),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez sélectionner une date de fin';
                          }
                          if (_startDate != null && _endDate != null && _endDate!.isBefore(_startDate!)) {
                            return 'La date de fin doit être après la date de début';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Row pour les heures
                      Row(
                        children: [
                          // Heure début
                          Expanded(
                            child: TextFormField(
                              controller: _startTimeController,
                              decoration: InputDecoration(
                                labelText: 'Heure début (hh:mm)',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: Icon(Icons.access_time),
                                suffixIcon: Icon(Icons.arrow_drop_down),
                              ),
                                                            readOnly: true,
                              onTap: () => _selectTime(context, true),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez sélectionner l\'heure de début';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          // Heure fin
                          Expanded(
                            child: TextFormField(
                              controller: _endTimeController,
                              decoration: InputDecoration(
                                labelText: 'Heure fin (hh:mm)',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: Icon(Icons.access_time),
                                suffixIcon: Icon(Icons.arrow_drop_down),
                              ),
                              readOnly: true,
                              onTap: () => _selectTime(context, false),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez sélectionner l\'heure de fin';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Affichage du nombre de jours
                      if (_startDate != null && _endDate != null)
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.event, color: Colors.blue),
                              SizedBox(width: 8),
                              Text(
                                'Nombre de jours: ${_calculateDays()}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
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

