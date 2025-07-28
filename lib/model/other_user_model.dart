// To parse this JSON data, do
//
//     final otherUserInfo = otherUserInfoFromJson(jsonString);

import 'dart:convert';

OtherUserInfo otherUserInfoFromJson(String str) =>
    OtherUserInfo.fromJson(json.decode(str));

String otherUserInfoToJson(OtherUserInfo data) => json.encode(data.toJson());

class OtherUserInfo {
  final User user;
  final Profile profile;

  OtherUserInfo({required this.user, required this.profile});

  factory OtherUserInfo.fromJson(Map<String, dynamic> json) => OtherUserInfo(
    user: User.fromJson(json["user"]),
    profile: Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "profile": profile.toJson(),
  };
}

class Profile {
  final String image;
  final String address;

  Profile({required this.image, required this.address});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      Profile(image: json["image"], address: json["address"]);

  Map<String, dynamic> toJson() => {"image": image, "address": address};
}

class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? lang;
  final String? lat;
  final String nationalId;
  final String nationalIdImage;

  User({
    this.lang,
    this.lat,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.nationalId,
    required this.nationalIdImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    lang: json["lang"],
    lat: json["lat"],
    nationalId: json["national_id"],
    nationalIdImage: json["national_id_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "lang": lang,
    "lat": lat,
    "national_id": nationalId,
    "national_id_image": nationalIdImage,
  };
}
