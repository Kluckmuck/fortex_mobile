class Waybill {
  int id;
  String name;

  Waybill(this.id, this.name);

  Waybill.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
      };
}