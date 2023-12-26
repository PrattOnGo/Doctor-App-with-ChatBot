class Hospital {
  final String name;
  final String address;
  final String location;
  final String? website;
  final String description;
  final int id;

  Hospital({
    required this.name,
    required this.address,
    required this.location,
    required this.website,
    required this.description,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'location': location,
      'website': website,
      'description': description,
      'id': id,
    };
  }

  factory Hospital.fromMap(Map<String, dynamic> map) {
    return Hospital(
      name: map['name'] as String,
      address: map['address'] as String,
      location: map['location'] as String,
      website: map['website'] != null ? map['website'] as String : null,
      description: map['description'] as String,
      id: map['id'] as int,
    );
  }

  @override
  String toString() {
    return 'Hospital(name: $name, address: $address, location: $location, website: $website, description: $description, id: $id)';
  }
}
