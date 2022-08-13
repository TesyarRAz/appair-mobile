class GeneralSetting {
  String appName;
  String mobileRekeningInfo;

  GeneralSetting({
    required this.appName,
    required this.mobileRekeningInfo,
  });

  factory GeneralSetting.fromJson(Map<String, dynamic> json) => GeneralSetting(
        appName: json["app_name"],
        mobileRekeningInfo: json['mobile_rekening_info'],
      );
}

class PriceSetting {
  int perKubik;
  int abudemen;

  PriceSetting({
    required this.perKubik,
    required this.abudemen,
  });

  factory PriceSetting.fromJson(Map<String, dynamic> json) => PriceSetting(
        perKubik: json['per_kubik'] is int
            ? json['per_kubik']
            : int.tryParse(json['per_kubik'] ?? '0') ?? 0,
        abudemen: json['abudemen'] is int
            ? json['abudemen']
            : int.tryParse(json['abudemen'] ?? '0') ?? 0,
      );
}

class StyleSetting {
  String? bgType;
  String? bgColor;
  String? bgImage;

  StyleSetting({
    required this.bgType,
    required this.bgColor,
    required this.bgImage,
  });

  factory StyleSetting.fromJson(Map<String, dynamic> json) => StyleSetting(
        bgType: json['bg_type'],
        bgColor: json['bg_color'],
        bgImage: json['bg_image'],
      );
}

class Setting {
  PriceSetting? price;
  GeneralSetting? general;
  StyleSetting? style;

  Setting({
    this.price,
    this.general,
    this.style,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        price:
            json["price"] == null ? null : PriceSetting.fromJson(json["price"]),
        general: json["general"] == null
            ? null
            : GeneralSetting.fromJson(json["general"]),
        style:
            json["style"] == null ? null : StyleSetting.fromJson(json["style"]),
      );
}
