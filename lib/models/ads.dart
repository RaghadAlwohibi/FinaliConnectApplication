import 'dart:convert';

class Ads {
  String id;
  String picture;
  String category;
  String description;
  String businessName;
  
  Ads({
    this.id,
    this.picture,
    this.category,
    this.description,
    this.businessName,
    
  });

  Ads copyWith({
    String id,
    String picture,
    String category,
    String description,
    String businessName,
    
  }) {
    return Ads(
      id: id ?? this.id,
      picture: picture ?? this.picture,
      category: category ?? this.category,
      description: description ?? this.description,
      businessName: businessName ?? this.businessName,
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'picture': picture,
      'category': category,
      'description': description,
      'businessName': businessName,
      
    };
  }

  static Ads fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Ads(
      id: map['id'],
      picture: map['picture'],
      category: map['category'],
      description: map['description'],
      businessName: map['businessName'],
     
    );
  }

  String toJson() => json.encode(toMap());

  static Ads fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ads(id: $id, picture: $picture, category: $category, description: $description, businessName: $businessName,)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Ads &&
        o.id == id &&
        o.picture == picture &&
        o.category == category &&
        o.description == description &&
        o.businessName == businessName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        picture.hashCode ^
        category.hashCode ^
        description.hashCode ^
        businessName.hashCode;
  }
}
