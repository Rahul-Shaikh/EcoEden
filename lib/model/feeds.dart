

class Feed {

  final int id;
  final String image;
  final String createdAt;
  final bool trash;
  final String user;
  final String lat;
  final String lng;
  final String description;

  Feed({this.id,
    this.image,
    this.createdAt,
    this.trash,
    this.user,
    this.lat,
    this.lng,
    this.description});

  factory Feed.fromJson(Map<String,dynamic> json) {

    return Feed(
      id: json['id'],
      image: json['image'],
      createdAt: json['created_at'],
      trash: json['trash'],
      user : json['user'],
      lat : json['lat'],
      lng : json['lng'],
      description : json['description'],
    );

  }
}