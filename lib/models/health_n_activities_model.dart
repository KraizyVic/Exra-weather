class HealthNActivitiesModel{
  final List<Lifestyle> healthNLifestyle;

  HealthNActivitiesModel({required this.healthNLifestyle});
}

class Lifestyle{
  final String title;
  final String inLineToolTip;
  final List<Factors> factors;

  Lifestyle({
    required this.title,
    required this.inLineToolTip,
    required this.factors
  });
}

class Factors{
  final String name;
  final String level;

  Factors({
    required this.name,
    required this.level,
  });
}
