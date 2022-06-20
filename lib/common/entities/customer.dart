class Customer {
  int id;
  bool active;

  Customer({
    required this.id,
    required this.active,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    active: json["active"] == 1 ? true : false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "active": active,
  };
}