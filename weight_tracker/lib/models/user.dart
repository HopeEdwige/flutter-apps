class User {
  int id;
  int age;
  int gender;
  double height;
  double initialWeight;
  double targetWeight;
  String name;

  User(
    this.name,
    this.gender,
    this.age,
    this.height,
    this.initialWeight,
    this.targetWeight,
  );

  User.fromMap(dynamic obj) {
    this.id = obj["id"];
    this.name = obj["name"];
    this.age = obj["age"];
    this.height = obj["height"];
    this.gender = obj["gender"];
    this.initialWeight = obj["initialWeight"];
    this.targetWeight = obj["targetWeight"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = this.id;
    map["name"] = this.name;
    map["age"] = this.age;
    map["height"] = this.height;
    map["gender"] = this.gender;
    map["initialWeight"] = this.initialWeight;
    map["targetWeight"] = this.targetWeight;
    return map;
  }
}
