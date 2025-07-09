import 'package:flutter/material.dart';
import '../models/models.dart';

class StatusColors {
  static Color getAbsenceStatusColor(AbsenceStatus status) {
    switch (status) {
      case AbsenceStatus.valide:
        return Colors.green;
      case AbsenceStatus.attente:
        return Colors.orange;
      case AbsenceStatus.refuse:
        return Colors.red;
    }
  }

  static Color getFraisMedicauxStatusColor(FraisMedicauxStatus status) {
    switch (status) {
      case FraisMedicauxStatus.valide:
        return Colors.green;
      case FraisMedicauxStatus.attente:
        return Colors.orange;
      case FraisMedicauxStatus.refuse:
        return Colors.red;
      case FraisMedicauxStatus.aJustifier:
        return Colors.purple;
    }
  }

  static Color getNoteFraisStatusColor(NoteFraisStatus status) {
    switch (status) {
      case NoteFraisStatus.valide:
        return Colors.green;
      case NoteFraisStatus.attente:
        return Colors.orange;
      case NoteFraisStatus.refuse:
        return Colors.red;
      case NoteFraisStatus.aJustifier:
        return Colors.purple;
    }
  }
}