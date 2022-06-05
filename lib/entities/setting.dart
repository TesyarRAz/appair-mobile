class Setting {
  PriceSetting? price;

  Setting({
    this.price,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        price: json["price"] == null ? null : PriceSetting.fromJson(json["price"]),
      );
}

class PriceSetting {
  int perKubik;

  PriceSetting({
    required this.perKubik,
  });

  factory PriceSetting.fromJson(Map<String, dynamic> json) => PriceSetting(
    perKubik: json['per_kubik'] is int ? json['per_kubik'] : int.tryParse(json['per_kubik'] ?? '0') ?? 0,
  );
}