// {
//   "gender": "female",
//   "name": {
//     "title": "Miss",
//     "first": "Jennie",
//     "last": "Nichols"
//   },
//   "location": {
//     "street": {
//       "number": 8929,
//       "name": "Valwood Pkwy",
//     },
//     "city": "Billings",
//     "state": "Michigan",
//     "country": "United States",
//     "postcode": "63104",
//     "coordinates": {
//       "latitude": "-69.8246",
//       "longitude": "134.8719"
//     },
//     "timezone": {
//       "offset": "+9:30",
//       "description": "Adelaide, Darwin"
//     }
//   },
//   "email": "jennie.nichols@example.com",
//   "login": {
//     "uuid": "7a0eed16-9430-4d68-901f-c0d4c1c3bf00",
//     "username": "yellowpeacock117",
//     "password": "addison",
//     "salt": "sld1yGtd",
//     "md5": "ab54ac4c0be9480ae8fa5e9e2a5196a3",
//     "sha1": "edcf2ce613cbdea349133c52dc2f3b83168dc51b",
//     "sha256": "48df5229235ada28389b91e60a935e4f9b73eb4bdb855ef9258a1751f10bdc5d"
//   },
//   "dob": {
//     "date": "1992-03-08T15:13:16.688Z",
//     "age": 30
//   },
//   "registered": {
//     "date": "2007-07-09T05:51:59.390Z",
//     "age": 14
//   },
//   "phone": "(272) 790-0888",
//   "cell": "(489) 330-2385",
//   "id": {
//     "name": "SSN",
//     "value": "405-88-3636"
//   },
//   "picture": {
//     "large": "https://randomuser.me/api/portraits/men/75.jpg",
//     "medium": "https://randomuser.me/api/portraits/med/men/75.jpg",
//     "thumbnail": "https://randomuser.me/api/portraits/thumb/men/75.jpg"
//   },
//   "nat": "US"
// }

import 'package:testme/model/models.dart';

// usser Model
class User {
  String? uuid;
  String? gender;
  String? title;
  String? email;
  String? firstName;
  String? lastName;
  String? username;
  String? password;
  String? phone;
  String? nat;
  DateModel? dob;
  DateModel? registered;
  Location? location;
  Picture? picture;

  User({
    this.uuid,
    this.gender,
    this.title,
    this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.password,
    this.phone,
    this.nat,
    this.dob,
    this.registered,
    this.location,
    this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uuid: json['login']['uuid'],
        gender: json['gender'],
        title: json['name']['title'],
        email: json['email'],
        firstName: json['name']['first'],
        lastName: json['name']['last'],
        username: json['login']['username'],
        password: json['login']['password'],
        phone: json['phone'],
        nat: json['nat'],
        dob: DateModel.fromJson(json['dob']),
        registered: DateModel.fromJson(json['registered']),
        location: Location.fromJson(json['location']),
        picture: Picture.fromJson(json['picture']),
      );

  factory User.fromDb(Map<String, dynamic> json) {
    return User(
      uuid: json["uuid"],
      gender: json["gender"],
      title: json["title"],
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      username: json["username"],
      password: json["password"],
      phone: json["phone"],
      nat: json["nat"],
      dob: DateModel.fromJson({
        "date": json["dob_date"],
        "age": json["dob_age"],
      }),
      registered: DateModel.fromJson({
        "date": json["registered_date"],
        "age": json["registered_age"],
      }),
      location: Location.fromJson({
        "city": json["location_city"],
        "state": json["location_state"],
        "country": json["location_country"],
        "postcode": json["location_postcode"],
      }),
      picture: Picture.fromJson({
        "large": json["picture_large"],
        "medium": json["picture_medium"],
        "thumbnail": json["picture_thumbnail"],
      }),
    );
  }

  Map<String, dynamic> toJson() {
    final dobJson = dob?.toJson();
    final registeredJson = registered?.toJson();
    final locationJson = location?.toJson();
    return <String, dynamic>{
      'uuid': uuid,
      'gender': gender,
      'email': email,
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'password': password,
      'phone': phone,
      'nat': nat,
      'dob_date': dobJson?['date'],
      'dob_age': dobJson?['age'],
      'registered_date': registeredJson?['date'],
      'registered_age': registeredJson?['age'],
      'location_city': locationJson?['city'],
      'location_state': locationJson?['state'],
      'location_country': locationJson?['country'],
      'location_postcode': locationJson?['postcode'],
      'picture_large': picture?.large,
      'picture_medium': picture?.medium,
      'picture_thumbnail': picture?.thumbnail,
    };
  }

  @override
  String toString() => '''
UUID: $uuid
Gender: $gender, Email: $email, Title: $title, First Name:$firstName,
Last Name: $lastName, Username: $username, Password: $password, Phone: $phone,
Nat: $nat, Dob: $dob, Registered: $registered, Location: $location, Picture: $picture
''';
}
