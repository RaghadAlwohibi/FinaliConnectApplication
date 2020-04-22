import 'package:iconnect/utils/utils.dart';

class Event {
  String id;
  int createdAt;
  String name;
  String brief;//breif
  String description;//description
  String gregoriandate;
  String location;
  String link;
  String time;
  String imageURL; 


  Event(
      {this.id,
      this.createdAt,
      this.brief,
      this.description,
      this.name,
      this.location,
      this.imageURL,
      this.gregoriandate,
      this.link,
      this.time,});

  factory Event.fromJson(Map<String, dynamic> json) {
 

    var events = Event(
        id: json['id'],
        createdAt: json['createdAt'],
        name: json['name'],
        brief: json['brief'],
        description: json['description'],
        time: json['time'],
        link: json['link'],
        location: json['location'],
        imageURL: json['imageURL'],
        gregoriandate: json ['gregoriandate'],
        );
        

    return events;
  }
 
  static Map<String, dynamic> toJson(Event events) {
    return {
      'id': events.id,
      'createdAt': events.createdAt,
      'link':events.link,
      'name': events.name,
     'gregoriandate': events.gregoriandate,    
      'location': events.location,
      'brief': events.brief,
      'description': events.description,
      'imageURL': events.imageURL,
      'time':events.time,
    };
  }
}

final List<Event> events = [
  Event(
      id: 'lala',
      name: 'Hunger',
      brief: 'I have found this glasses. Does it belong to anybody?',
      description: 'I have found this glasses. Does it belong to anybody?',
      createdAt: DateTime.now().millisecondsSinceEpoch,
      imageURL: AvailableImages.lostItemImage2,
      location: 'IT department B blok'),
 
];
