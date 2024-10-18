class DestinasiWisata {
  int? id;
  String? destination;
  String? location;
  String? attraction;

  DestinasiWisata({
    this.id,
    this.destination,
    this.location,
    this.attraction,
  });

  
  factory DestinasiWisata.fromJson(Map<String, dynamic> obj) {
    return DestinasiWisata(
      id: obj['id'],
      destination: obj['destination'],
      location: obj['location'],
      attraction: obj['attraction'],
    );
  }

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'destination': destination,
      'location': location,
      'attraction': attraction,
    };
  }
}
