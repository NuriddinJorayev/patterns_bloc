class Post {
  int id;
  String fullname;
  String phone;

  Post(this.id, this.fullname, this.phone);

  Post.fromJson(dynamic json)
      : id = int.parse(json['id']),
        fullname = json['fullname'],
        phone = json['phone'];

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'fullname': fullname,
        'phone': phone,
      };
}
