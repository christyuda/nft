// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

List<Profile> listProfileFromJson(String str) =>
    List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String listProfileToJson(List<Profile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profile {
  Profile({
    required this.id,
    required this.roleId,
  });

  int id;
  int roleId;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
      };
}
