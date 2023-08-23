// "location": {
//   "street": {
//     "number": 8929,
//     "name": "Valwood Pkwy",
//   },
//   "city": "Billings",
//   "state": "Michigan",
//   "country": "United States",
//   "postcode": "63104",
//   "coordinates": {
//     "latitude": "-69.8246",
//     "longitude": "134.8719"
//   },
//   "timezone": {
//     "offset": "+9:30",
//     "description": "Adelaide, Darwin"
//   }
// },

// Location Model

class Location {
  String? city;
  String? state;
  String? country;
  String? postcode;

  Location({
    this.city,
    this.state,
    this.country,
    this.postcode,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postcode: json["postcode"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "country": country,
        "postcode": postcode,
      };

  @override
  String toString() {
    return 'Location{city: $city, state: $state, country: $country, postcode: $postcode}';
  }
}
