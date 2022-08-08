class GeneralSetting {
  String mobileRekeningInfo;

  GeneralSetting({
    required this.mobileRekeningInfo,
  });

  factory GeneralSetting.fromJson(Map<String, dynamic> json) => GeneralSetting(
        mobileRekeningInfo: json['mobile_rekening_info'],
      );
}

class PriceSetting {
  int perKubik;

  PriceSetting({
    required this.perKubik,
  });

  factory PriceSetting.fromJson(Map<String, dynamic> json) => PriceSetting(
        perKubik: json['per_kubik'] is int
            ? json['per_kubik']
            : int.tryParse(json['per_kubik'] ?? '0') ?? 0,
      );
}

class Setting {
  PriceSetting? price;
  GeneralSetting? general;

  Setting({
    this.price,
    this.general,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        price:
            json["price"] == null ? null : PriceSetting.fromJson(json["price"]),
        general: json["general"] == null
            ? null
            : GeneralSetting.fromJson(json["general"]),
      );
}
