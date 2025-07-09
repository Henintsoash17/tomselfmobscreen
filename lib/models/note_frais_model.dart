class NoteFrais {
  final int id;
  final String nomUser;
  final String numeroDemande;
  final String refFacture;
  final String description;
  final NoteFraisStatus status;
  final List<NoteFraisDetail> details;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? commentaire;

  NoteFrais({
    required this.id,
    required this.nomUser,
    required this.numeroDemande,
    required this.refFacture,
    required this.description,
    required this.status,
    required this.details,
    required this.createdAt,
    required this.updatedAt,
    this.commentaire,
  });

  factory NoteFrais.fromJson(Map<String, dynamic> json) {
    return NoteFrais(
      id: json['id'] ?? 0,
      nomUser: json['nomUser'] ?? '',
      numeroDemande: json['numeroDemande'] ?? '',
      refFacture: json['refFacture'] ?? '',
      description: json['description'] ?? '',
      status: NoteFraisStatus.fromString(json['status'] ?? 'attente'),
      details: json['details'] != null
          ? (json['details'] as List).map((detail) => NoteFraisDetail.fromJson(detail)).toList()
          : [],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      commentaire: json['commentaire'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomUser': nomUser,
      'numeroDemande': numeroDemande,
      'refFacture': refFacture,
      'description': description,
      'status': status.value,
      'details': details.map((detail) => detail.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'commentaire': commentaire,
    };
  }

  NoteFrais copyWith({
    int? id,
    String? nomUser,
    String? numeroDemande,
    String? refFacture,
    String? description,
    NoteFraisStatus? status,
    List<NoteFraisDetail>? details,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? commentaire,
  }) {
    return NoteFrais(
      id: id ?? this.id,
      nomUser: nomUser ?? this.nomUser,
      numeroDemande: numeroDemande ?? this.numeroDemande,
      refFacture: refFacture ?? this.refFacture,
      description: description ?? this.description,
      status: status ?? this.status,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      commentaire: commentaire ?? this.commentaire,
    );
  }

  double get montantTotal {
    return details.fold(0.0, (sum, detail) => sum + detail.montantLocal);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NoteFrais && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'NoteFrais(id: $id, nomUser: $nomUser, numeroDemande: $numeroDemande, status: $status)';
  }
}

class NoteFraisDetail {
  final String rubrique;
  final String description;
  final String tiers;
  final String tiersAuxiliaire;
  final double montantLocal;
  final DateTime? dateDepense;
  final String? devise;

  NoteFraisDetail({
    required this.rubrique,
    required this.description,
    required this.tiers,
    required this.tiersAuxiliaire,
    required this.montantLocal,
    this.dateDepense,
    this.devise,
  });

  factory NoteFraisDetail.fromJson(Map<String, dynamic> json) {
    return NoteFraisDetail(
      rubrique: json['rubrique'] ?? '',
      description: json['description'] ?? '',
      tiers: json['tiers'] ?? '',
      tiersAuxiliaire: json['tiersAuxiliaire'] ?? '',
      montantLocal: (json['montantLocal'] ?? 0.0).toDouble(),
      dateDepense: json['dateDepense'] != null ? DateTime.parse(json['dateDepense']) : null,
      devise: json['devise'] ?? 'EUR',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rubrique': rubrique,
      'description': description,
      'tiers': tiers,
      'tiersAuxiliaire': tiersAuxiliaire,
      'montantLocal': montantLocal,
      'dateDepense': dateDepense?.toIso8601String(),
      'devise': devise,
    };
  }

  NoteFraisDetail copyWith({
    String? rubrique,
    String? description,
    String? tiers,
    String? tiersAuxiliaire,
    double? montantLocal,
    DateTime? dateDepense,
    String? devise,
  }) {
    return NoteFraisDetail(
      rubrique: rubrique ?? this.rubrique,
      description: description ?? this.description,
      tiers: tiers ?? this.tiers,
      tiersAuxiliaire: tiersAuxiliaire ?? this.tiersAuxiliaire,
      montantLocal: montantLocal ?? this.montantLocal,
      dateDepense: dateDepense ?? this.dateDepense,
      devise: devise ?? this.devise,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NoteFraisDetail &&
        other.rubrique == rubrique &&
        other.description == description &&
        other.tiers == tiers &&
        other.tiersAuxiliaire == tiersAuxiliaire &&
        other.montantLocal == montantLocal;
  }

  @override
  int get hashCode {
    return Object.hash(rubrique, description, tiers, tiersAuxiliaire, montantLocal);
  }

  @override
  String toString() {
    return 'NoteFraisDetail(rubrique: $rubrique, description: $description, montantLocal: $montantLocal)';
  }
}

enum NoteFraisStatus {
  valide('validé'),
  attente('attente'),
  refuse('refusé'),
  aJustifier('à justifier');

  const NoteFraisStatus(this.value);
  final String value;

  static NoteFraisStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'validé':
        return NoteFraisStatus.valide;
      case 'attente':
        return NoteFraisStatus.attente;
      case 'refusé':
        return NoteFraisStatus.refuse;
      case 'à justifier':
        return NoteFraisStatus.aJustifier;
      default:
        return NoteFraisStatus.attente;
    }
  }

  @override
  String toString() => value;
}