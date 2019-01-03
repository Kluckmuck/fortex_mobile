class ElementString {
  int id;
  String name;
  String value;

  ElementString({this.id, this.name, this.value});

  factory ElementString.fromJson(Map<String, dynamic> parsedJson){
    return ElementString(
        id:parsedJson['id'],
        name:parsedJson['name'],
        value:parsedJson['vale']
    );
  }
}