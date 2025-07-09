class FraisMedicaux {
  final int id;
  final String nom;
  final String libelle;
  final String refFacture;
  final String medecin;
  final String typeTraitement;
  final String observation;
  final FraisMedicauxStatus status;
  final double montantFacture;
  final double montantDemande;
  final double montantRembourse;
  final String commentaire;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String>? documents;

  FraisMedicaux({
    required this.id,
    required this.nom,
    required this.libelle,
    required this.refFacture,
    required this.medecin,
    required this.typeTraitement,
    required this.observation,
    required this.status,
    required this.montantFacture,
    required this.montantDemande,
    required this.montantRembourse,
    required this.commentaire,
    required this.createdAt,
    required this.updatedAt,
    this.documents,
  });

  factory FraisMedicaux.fromJson(Map<String, dynamic> json) {
    return FraisMedicaux(
      id: json['id'] ?? 0,
      nom: json['nom'] ?? '',
      libelle: json['libelle'] ?? '',
      refFacture: json['refFacture'] ?? '',
      medecin: json['medecin'] ?? '',
      typeTraitement: json['typeTraitement'] ?? '',
      observation: json['observation'] ?? '',
      status: FraisMedicauxStatus.fromString(json['status'] ?? 'attente'),
      montantFacture: (json['montantFacture'] ?? 0.0).toDouble(),
      montantDemande: (json['montantDemande'] ?? 0.0).toDouble(),
      montantRembourse: (json['montantRembourse'] ?? 0.0).toDouble(),
      commentaire: json['commentaire'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      documents: json['documents'] != null ? List<String>.from(json['documents']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'libelle': libelle,
      'refFacture': refFacture,
      'medecin': medecin,
      'typeTraitement': typeTraitement,
      'observation': observation,
      'status': status.value,
      'montantFacture': montantFacture,
      'montantDemande': montantDemande,
      'montantRembourse': montantRembourse,
      'commentaire': commentaire,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'documents': documents,
    };
  }

  FraisMedicaux copyWith({
    int? id,
    String? nom,
    String? libelle,
    String? refFacture,
    String? medecin,
    String? typeTraitement,
    String? observation,
    FraisMedicauxStatus? status,
    double? montantFacture,
    double? montantDemande,
    double? montantRembourse,
    String? commentaire,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? documents,
  }) {
    return FraisMedicaux(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      libelle: libelle ?? this.libelle,
      refFacture: refFacture ?? this.refFacture,
      medecin: medecin ?? this.medecin,
      typeTraitement: typeTraitement ?? this.typeTraitement,
      observation: observation ?? this.observation,
      status: status ?? this.status,
      montantFacture: montantFacture ?? this.montantFacture,
      montantDemande: montantDemande ?? this.montantDemande,
      montantRembourse: montantRembourse ?? this.montantRembourse,
      commentaire: commentaire ?? this.commentaire,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      documents: documents ?? this.documents,
    );
  }

  double get tauxRemboursement {
    if (montantFacture == 0) return 0.0;
    return (montantRembourse / montantFacture) * 100;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FraisMedicaux && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'FraisMedicaux(id: $id, nom: $nom, libelle: $libelle, status: $status, montantFacture: $montantFacture)';
  }
}

enum FraisMedicauxStatus {
  valide('validé'),
  attente('attente'),
  refuse('refusé'),
  aJustifier('à justifier');

  const FraisMedicauxStatus(this.value);
  final String value;

  static FraisMedicauxStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'validé':
        return FraisMedicauxStatus.valide;
      case 'attente':
        return FraisMedicauxStatus.attente;
      case 'refusé':
        return FraisMedicauxStatus.refuse;
      case 'à justifier':
        return FraisMedicauxStatus.aJustifier;
      default:
        return FraisMedicauxStatus.attente;
    }
  }

  @override
  String toString() => value;
}