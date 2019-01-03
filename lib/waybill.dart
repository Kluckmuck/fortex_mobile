import 'elementString.dart';

class Waybill {
  int id;
  String name;
  String employee;
  String date;
  List<ElementString> elementStrings;

  Waybill({this.id, this.name, this.employee, this.date, this.elementStrings});

  Waybill.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        employee = json['employee'],
        date = json['date'];



  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'employee': employee,
        'date': date
      };
}