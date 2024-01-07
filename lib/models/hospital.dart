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

  Hospital copyWith({
    String? name,
    String? address,
    String? location,
    String? website,
    String? description,
    int? id,
  }) {
    return Hospital(
      name: name ?? this.name,
      address: address ?? this.address,
      location: location ?? this.location,
      website: website ?? this.website,
      description: description ?? this.description,
      id: id ?? this.id,
    );
  }
}
