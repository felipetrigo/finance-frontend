class Client{
  int id;
  String name;
  double salary;
  bool deleted;
  Client(this.id,this.name,this.salary,this.deleted);
  factory Client.fromJson(Map json){
    return Client(json['id'], json['name'], json['salary'], json['deleted']);
  }
}