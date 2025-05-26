class AddressModel {
  final String line1;
  final String line2;
  final String area;
  final String city;
  final String state;
  final String country;
  final String zip;
  final double latitude;
  final double longitude;

  AddressModel({
    required this.line1,
    required this.line2,
    required this.area,
    required this.city,
    required this.state,
    required this.country,
    required this.zip,
    required this.latitude,
    required this.longitude,
  });

  AddressModel copyWith({
    String? line1,
    String? line2,
    String? area,
    String? city,
    String? state,
    String? country,
    String? zip,
    double? latitude,
    double? longitude,
  }) {
    return AddressModel(
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      area: area ?? this.area,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zip: zip ?? this.zip,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toJson() => {
    'line1': line1,
    'line2': line2,
    'area': area,
    'city': city,
    'state': state,
    'country': country,
    'zip': zip,
    'latitude': latitude,
    'longitude': longitude,
  };

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    line1: json['line1'] ?? '',
    line2: json['line2'] ?? '',
    area: json['area'] ?? '',
    city: json['city'] ?? '',
    state: json['state'] ?? '',
    country: json['country'] ?? '',
    zip: json['zip'] ?? '',
    latitude: json['latitude']?.toDouble() ?? 0.0,
    longitude: json['longitude']?.toDouble() ?? 0.0,
  );
}
