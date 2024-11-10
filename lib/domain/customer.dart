class customer{
  int id;
  String name;
  double salary;
  String phoneNumber;
  String email;
  customer(this.id,this.name,this.salary,this.phoneNumber,this.email);
  factory customer.fromJSON(Map<String, dynamic> json){
    return customer(json['id'], json['name'], json['salary'], json['phoneNumber'], json['email']);
  }
}