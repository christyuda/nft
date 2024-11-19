// To parse this JSON data, do
//
//     final userDummy = userDummyFromJson(jsonString);

import 'dart:convert';

UserDummy userDummyFromJson(String str) => UserDummy.fromJson(json.decode(str));

String userDummyToJson(UserDummy data) => json.encode(data.toJson());

class UserDummy {
  UserDummy({
    this.id,
    this.firstName,
    this.lastName,
    this.maidenName,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.birthDate,
    this.image,
    this.bloodGroup,
    this.height,
    this.weight,
    this.eyeColor,
    this.hair,
    this.domain,
    this.ip,
    this.address,
    this.macAddress,
    this.university,
    this.bank,
    this.company,
    this.ein,
    this.ssn,
    this.userAgent,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? maidenName;
  int? age;
  String? gender;
  String? email;
  String? phone;
  String? username;
  String? password;
  DateTime? birthDate;
  String? image;
  String? bloodGroup;
  int? height;
  double? weight;
  String? eyeColor;
  Hair? hair;
  String? domain;
  String? ip;
  Address? address;
  String? macAddress;
  String? university;
  Bank? bank;
  Company? company;
  String? ein;
  String? ssn;
  String? userAgent;

  factory UserDummy.fromJson(Map<String, dynamic> json) => UserDummy(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        maidenName: json["maidenName"],
        age: json["age"],
        gender: json["gender"],
        email: json["email"],
        phone: json["phone"],
        username: json["username"],
        password: json["password"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
        image: json["image"],
        bloodGroup: json["bloodGroup"],
        height: json["height"],
        weight: json["weight"]?.toDouble(),
        eyeColor: json["eyeColor"],
        hair: json["hair"] == null ? null : Hair.fromJson(json["hair"]),
        domain: json["domain"],
        ip: json["ip"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        macAddress: json["macAddress"],
        university: json["university"],
        bank: json["bank"] == null ? null : Bank.fromJson(json["bank"]),
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
        ein: json["ein"],
        ssn: json["ssn"],
        userAgent: json["userAgent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "maidenName": maidenName,
        "age": age,
        "gender": gender,
        "email": email,
        "phone": phone,
        "username": username,
        "password": password,
        "birthDate":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "image": image,
        "bloodGroup": bloodGroup,
        "height": height,
        "weight": weight,
        "eyeColor": eyeColor,
        "hair": hair?.toJson(),
        "domain": domain,
        "ip": ip,
        "address": address?.toJson(),
        "macAddress": macAddress,
        "university": university,
        "bank": bank?.toJson(),
        "company": company?.toJson(),
        "ein": ein,
        "ssn": ssn,
        "userAgent": userAgent,
      };
}

class Address {
  Address({
    this.address,
    this.city,
    this.coordinates,
    this.postalCode,
    this.state,
  });

  String? address;
  String? city;
  Coordinates? coordinates;
  String? postalCode;
  String? state;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        city: json["city"],
        coordinates: json["coordinates"] == null
            ? null
            : Coordinates.fromJson(json["coordinates"]),
        postalCode: json["postalCode"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "coordinates": coordinates?.toJson(),
        "postalCode": postalCode,
        "state": state,
      };
}

class Coordinates {
  Coordinates({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Bank {
  Bank({
    this.cardExpire,
    this.cardNumber,
    this.cardType,
    this.currency,
    this.iban,
  });

  String? cardExpire;
  String? cardNumber;
  String? cardType;
  String? currency;
  String? iban;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        cardExpire: json["cardExpire"],
        cardNumber: json["cardNumber"],
        cardType: json["cardType"],
        currency: json["currency"],
        iban: json["iban"],
      );

  Map<String, dynamic> toJson() => {
        "cardExpire": cardExpire,
        "cardNumber": cardNumber,
        "cardType": cardType,
        "currency": currency,
        "iban": iban,
      };
}

class Company {
  Company({
    this.address,
    this.department,
    this.name,
    this.title,
  });

  Address? address;
  String? department;
  String? name;
  String? title;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        department: json["department"],
        name: json["name"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "department": department,
        "name": name,
        "title": title,
      };
}

class Hair {
  Hair({
    this.color,
    this.type,
  });

  String? color;
  String? type;

  factory Hair.fromJson(Map<String, dynamic> json) => Hair(
        color: json["color"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
        "type": type,
      };
}
