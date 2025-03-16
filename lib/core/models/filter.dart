class FilterModel {
  final double? caratFrom;
  final double? caratTo;
  final String? lab;
  final String? shape;
  final String? color;
  final String? clarity;

  const FilterModel({
    this.caratFrom,
    this.caratTo,
    this.lab,
    this.shape,
    this.color,
    this.clarity,
  });

  // CopyWith method for immutability
  FilterModel copyWith({
    double? caratFrom,
    double? caratTo,
    String? lab,
    String? shape,
    String? color,
    String? clarity,
  }) {
    return FilterModel(
      caratFrom: caratFrom ?? this.caratFrom,
      caratTo: caratTo ?? this.caratTo,
      lab: lab ?? this.lab,
      shape: shape ?? this.shape,
      color: color ?? this.color,
      clarity: clarity ?? this.clarity,
    );
  }

  // Convert to JSON for debugging/logging
  Map<String, dynamic> toJson() {
    return {
      'caratFrom': caratFrom,
      'caratTo': caratTo,
      'lab': lab,
      'shape': shape,
      'color': color,
      'clarity': clarity,
    };
  }
}
