class Customer {
  int id;
  bool active;
  int rt;
  int lastMeter;
  bool isAllLunas;

  Customer({
    required this.id,
    required this.active,
    required this.rt,
    required this.lastMeter,
    required this.isAllLunas,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    active: json["active"],
    rt: json["rt"],
    lastMeter: json["last_meter"],
    isAllLunas: json["is_all_lunas"],
  );
}