class BmiEntry {
  final double weight;
  final double height;
  final DateTime date;

  BmiEntry({required this.weight, required this.height, required this.date});

  double get bmi => weight / ((height / 100) * (height / 100));

  String get category {
    final b = bmi;
    if (b < 18.5) return "Untergewicht";
    if (b < 25) return "Normalgewicht";
    if (b < 30) return "Übergewicht";
    if (b < 35) return "Adipositas I";
    if (b < 40) return "Adipositas II";
    return "Adipositas III";
  }

  Map<String, dynamic> toMap() => {
    'weight': weight,
    'height': height,
    'date': date.toIso8601String(),
  };

  factory BmiEntry.fromMap(Map<String, dynamic> map) => BmiEntry(
    weight: map['weight'],
    height: map['height'],
    date: DateTime.parse(map['date']),
  );
}