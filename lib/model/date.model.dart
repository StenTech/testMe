/// {
///   "date": "1992-03-08T15:13:16.688Z",
///   "age": 30
/// },
///

class DateModel {
  DateTime? date;
  int? age;

  DateModel({
    this.date,
    this.age,
  });

  factory DateModel.fromJson(Map<String, dynamic> json) => DateModel(
        date: DateTime.tryParse(json['date']),
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "age": age,
      };

  @override
  String toString() {
    return 'DateModel{date: $date, age: $age}';
  }
}
