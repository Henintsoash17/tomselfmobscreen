class Absence {
  final String id;
  final String userName;
  final String startDate;
  final String endDate;
  final int days;
  final AbsenceStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? reason;
  final String? comment;

  Absence({
    required this.id,
    required this.userName,
    required this.startDate,
    required this.endDate,
    required this.days,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.reason,
    this.comment,
  });

  factory Absence.fromJson(Map<String, dynamic> json) {
    return Absence(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      days: json['days'] ?? 0,
      status: AbsenceStatus.fromString(json['status'] ?? 'attente'),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      reason: json['reason'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'startDate': startDate,
      'endDate': endDate,
      'days': days,
      'status': status.value,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'reason': reason,
      'comment': comment,
    };
  }

  Absence copyWith({
    String? id,
    String? userName,
    String? startDate,
    String? endDate,
    int? days,
    AbsenceStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? reason,
    String? comment,
  }) {
    return Absence(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      days: days ?? this.days,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reason: reason ?? this.reason,
      comment: comment ?? this.comment,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Absence && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Absence(id: $id, userName: $userName, startDate: $startDate, endDate: $endDate, days: $days, status: $status)';
  }
}

enum AbsenceStatus {
  valide('validé'),
  attente('attente'),
  refuse('refusé');

  const AbsenceStatus(this.value);
  final String value;

  static AbsenceStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'validé':
        return AbsenceStatus.valide;
      case 'attente':
        return AbsenceStatus.attente;
      case 'refusé':
        return AbsenceStatus.refuse;
      default:
        return AbsenceStatus.attente;
    }
  }

  @override
  String toString() => value;
}