class Spent {
  int id;
  double price;
  double percentage;
  String name;

  Spent(this.id, this.price, this.percentage, this.name);

  factory Spent.fromJson(Map<String, dynamic> json) {
    //print("${json['id']} ${json['price']} ${json['percentage']} ${json['name']}");
    return Spent(json['id'], json['price'], json['percentage'], json['name']);
  }
}