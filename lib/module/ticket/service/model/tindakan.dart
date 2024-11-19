class Tindakan {
  Tindakan({
    this.id,
    this.namatindakan,
  });

  int? id;
  String? namatindakan;

  factory Tindakan.fromJson(Map<String, dynamic> json) => Tindakan(
        id: json["id"],
        namatindakan: json["namatindakan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "namatindakan": namatindakan,
      };
}
