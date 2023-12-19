class Blood {
  final int id;
  final String bloodGroup;
  final int amount;
  final int hospital;
  Blood({
    required this.id,
    required this.bloodGroup,
    required this.amount,
    required this.hospital,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bloodGroup': bloodGroup,
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
    );
  }

  @override
  String toString() {
    return 'Blood(id: $id, bloodGroup: $bloodGroup, amount: $amount, hospital: $hospital)';
  }
}
