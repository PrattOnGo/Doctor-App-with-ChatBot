class Doctor {
  final String name;
  final int hospital;
  final String specialty;
  final Map<String, dynamic> availability;
  final String user_id;

  Doctor({
    required this.name,
    required this.hospital,
    required this.specialty,
    required this.availability,
    required this.user_id,
  });

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      name: map['name'] as String,
      hospital: map['hospital'] as int,
      specialty: map['specialty'] as String,
      availability: map['availability'] as Map<String, dynamic>,
      user_id: map['user_id'] as String,
    );
  }
}
