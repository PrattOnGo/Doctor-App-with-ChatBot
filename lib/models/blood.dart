import 'package:healthsphere/models/hospital.dart';

class Blood {
  final int id;
  final String bloodGroup;
  final int amount;
  final int hospital;
  final Hospital hospitalName;

  Blood({
    required this.id,
    required this.bloodGroup,
    required this.amount,
    required this.hospital,
    required this.hospitalName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bloodGroup': bloodGroup,
      'amount': amount,
      'hospital': hospital,
      'hospitalName': hospitalName,
    };
  }

  factory Blood.fromMap(Map<String, dynamic> map) {
    return Blood(
      id: map['id'] as int,
      bloodGroup: map['blood_group'] as String,
      amount: map['amount'] as int,
      hospital: map['hospital'] as int,
      hospitalName: map['hospitalName'] as Hospital,
    );
  }

  @override
  String toString() {
    return 'Blood(id: $id, bloodGroup: $bloodGroup, amount: $amount, hospital: $hospital)';
  }
}
