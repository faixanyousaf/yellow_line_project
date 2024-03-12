class CarModel {
  int? cityMpg;
  int? combinationMpg;
  int? cylinders;
  double? displacement;
  String? drive;
  String? fuelType;
  int? highwayMpg;
  String? make;
  String? model;
  String? transmission;
  int? year;

  CarModel(
      {this.cityMpg,
        this.combinationMpg,
        this.cylinders,
        this.displacement,
        this.drive,
        this.fuelType,
        this.highwayMpg,
        this.make,
        this.model,
        this.transmission,
        this.year});

  CarModel.fromJson(Map<String, dynamic> json) {
    cityMpg = json['city_mpg'];
    combinationMpg = json['combination_mpg'];
    cylinders = json['cylinders'];
    displacement = json['displacement'];
    drive = json['drive'];
    fuelType = json['fuel_type'];
    highwayMpg = json['highway_mpg'];
    make = json['make'];
    model = json['model'];
    transmission = json['transmission'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_mpg'] = this.cityMpg;
    data['combination_mpg'] = this.combinationMpg;
    data['cylinders'] = this.cylinders;
    data['displacement'] = this.displacement;
    data['drive'] = this.drive;
    data['fuel_type'] = this.fuelType;
    data['highway_mpg'] = this.highwayMpg;
    data['make'] = this.make;
    data['model'] = this.model;
    data['transmission'] = this.transmission;
    data['year'] = this.year;
    return data;
  }
}
