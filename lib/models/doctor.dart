import 'dart:convert';

class Doctor {
  final String name;
  final int hospital;
  final String specialty;
  final String availability;
  final String user_id;
  final String? hospitalName;
  final int id;

  Doctor({
    required this.name,
    required this.hospital,
    required this.specialty,
    required this.availability,
    required this.user_id,
    this.hospitalName,
    required this.id,
  });

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      name: map['name'] as String,
      hospital: map['hospital'] as int,
      specialty: map['specialty'] as String,
      availability: map['availability'] as String,
      user_id: map['user_id'] as String,
      hospitalName:
          map['hospitalName'] != null ? map['hospitalName'] as String : null,
      id: map['id'] as int,
    );
  }

  factory Doctor.fromMapFull(Map<String, dynamic> map) {
    return Doctor(
      name: map['name'] as String,
      hospital: map['hospital'] as int,
      specialty: map['specialty'] as String,
      availability: map['availability'] as String,
      user_id: map['user_id'] as String,
      hospitalName: map['hospitalName'] as String,
      id: map['id'] as int,
    );
  }

  Doctor copyWith({
    String? name,
    int? hospital,
    String? specialty,
    String? availability,
    String? user_id,
    String? hospitalName,
    int? id,
  }) {
    return Doctor(
      name: name ?? this.name,
      hospital: hospital ?? this.hospital,
      specialty: specialty ?? this.specialty,
      availability: availability ?? this.availability,
      user_id: user_id ?? this.user_id,
      hospitalName: hospitalName ?? this.hospitalName,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'specialty': specialty,
      'availability': availability,
    };
  }

  String toJson() => json.encode(toMap());

  factory Doctor.fromJson(String source) =>
      Doctor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Doctor(name: $name, hospital: $hospital, specialty: $specialty, availability: $availability, user_id: $user_id, hospitalName: $hospitalName, id: $id)';
  }
}
