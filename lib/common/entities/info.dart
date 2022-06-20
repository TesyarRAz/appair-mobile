class Info {
  int id;
  String title;
  String description;
  String? image;
  String? url;

  Info({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    this.url,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "url": url,
  };
}