import 'elementString.dart';

class Waybill {
  int id;
  String name;
  String employee;
  String date;
  List<ElementString> elementStrings;

  Waybill({this.id, this.name, this.employee, this.date, this.elementStrings});

  factory Waybill.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['elementString'] as List;
    List<ElementString> stringList = list.map((i) => ElementString.fromJson(i)).toList();


    return Waybill(
        id: parsedJson['id'],
        name: parsedJson['name'],
        employee: parsedJson['employee'],
        date: parsedJson['date'],
        elementStrings: stringList
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'employee': employee,
        'date': date
      };
}