class PlacesList {
  int? id;
  String name;

  PlacesList({this.id, required this.name});

  Map<String, dynamic> toMap() => {if (id != null) 'id': id, 'name': name};

  factory PlacesList.fromMap(Map<String, dynamic> m) =>
      PlacesList(id: m['id'], name: m['name']);
}
