import 'package:iconnect/utils/utils.dart';

class Ads {
  String id;
  int date;
  String businessName;
  String duration;//breif
  String description;//description
  String category;
  String state; 
  String picture; 


  Ads(
      {this.id,
      this.date,
      this.duration,
      this.description,
      this.businessName,
      this.state,
      this.category,
      this.picture,
     });

  factory Ads.fromJson(Map<String, dynamic> json) {
 

    var ads = Ads(
        id: json['id'],
        date: json['date'],
        duration: json['duration'],
        description: json['description'],
        businessName: json['businessName'],
        state: json['state'],
        category: json['category'],
        picture: json['picture'],

        );
        

    return ads;
  }
 
  static Map<String, dynamic> toJson(Ads ads) {
    return {
      'id': ads.id,
      'date': ads.date,
      'duration':ads.duration,
      'description': ads.description,
      'businessName': ads.businessName,
      'state': ads.state,
      'category': ads.category,
      'picture': ads.picture,
    };
  }
}

final List<Ads> ads = [
  Ads(
      id: 'lala',
      date: DateTime.now().millisecondsSinceEpoch,
      duration: 'Hunger',
      description: 'I have found this glasses. Does it belong to anybody?',
      businessName: 'I have found this glasses. Does it belong to anybody?',
      category: 'Food',
      picture: AvailableImages.lostItemImage2,
      state:'accepted'),
 
];
