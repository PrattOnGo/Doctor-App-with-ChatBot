// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  Map<String, dynamic> toMapSpecial() {
    return <String, dynamic>{
      'blood_group': bloodGroup,
      'amount': amount,
      'hospital': hospital,
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

  Blood copyWith({
    int? id,
    String? bloodGroup,
    int? amount,
    int? hospital,
    Hospital? hospitalName,
  }) {
    return Blood(
      id: id ?? this.id,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      amount: amount ?? this.amount,
      hospital: hospital ?? this.hospital,
      hospitalName: hospitalName ?? this.hospitalName,
    );
  }
}
