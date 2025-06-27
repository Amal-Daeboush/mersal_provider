import 'dart:convert';

class UserModel {
    String accessToken;
    User user;

    UserModel({
        required this.accessToken,
        required this.user,
    });

    factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        accessToken: json["access_token"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "user": user.toJson(),
    };
     @override
  String toString() {
    return toJson().toString();
  }

}

class User {
    final int id;
    final String name;
    final dynamic? googleId;
    final dynamic? facebookId;
    final String? otp;
    final String? status;
    final String? email;
    final String? nationalId;
    final dynamic imagePath;
    final dynamic phone;
    final dynamic emailVerifiedAt;
    final String? type;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Profile? profile;

    User({
        required this.id,
        required this.name,
        this.googleId,
        this.facebookId,
        this.otp,
        this.status,
        this.email,
        this.nationalId,
        this.imagePath,
        this.phone,
        this.emailVerifiedAt,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.profile,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        googleId: json["google_id"],
        facebookId: json["facebook_id"],
        otp: json["otp"],
        status: json["status"],
        email: json["email"],
        nationalId: json["national_id"],
        imagePath: json["image_path"],
        phone: json["phone"],
        emailVerifiedAt: json["email_verified_at"],
        type: json["type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "google_id": googleId,
        "facebook_id": facebookId,
        "otp": otp,
        "status": status,
        "email": email,
        "national_id": nationalId,
        "image_path": imagePath,
        "phone": phone,
        "email_verified_at": emailVerifiedAt,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "profile": profile?.toJson(),
    };
  @override
  String toString() {
    return toJson().toString();
  }
 
}

class Profile {
    int id;
    String userId;
    String lang;
    String lat;
    String address;
    String image;
    DateTime createdAt;
    DateTime updatedAt;

    Profile({
        required this.id,
        required this.userId,
        required this.lang,
        required this.lat,
        required this.address,
        required this.image,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        userId: json["user_id"],
        lang: json["lang"],
        lat: json["lat"],
        address: json["address"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
 @override
  String toString() {
    return toJson().toString();
  }

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "lang": lang,
        "lat": lat,
        "address": address,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
