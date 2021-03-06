import 'dart:convert';

class AdRequest {
  String id;
  String picture;
  String category;
  String description;
  String businessName;
  String state;
  AdRequest({
    this.id,
    this.picture,
    this.category,
    this.description,
    this.businessName,
    
    this.state,
  });

  AdRequest copyWith({
    String id,
    String picture,
    String category,
    String description,
    String businessName,
    String state,
  }) {
    return AdRequest(
      id: id ?? this.id,
      picture: picture ?? this.picture,
      category: category ?? this.category,
      description: description ?? this.description,
      businessName: businessName ?? this.businessName,
      
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'picture': picture,
      'category': category,
      'description': description,
      'businessName': businessName,
      'state': state,
    };
  }

  static AdRequest fromMap(Map<String, dynamic> map, String docId) {
    if (map == null) return null;

    return AdRequest(
      id: docId,
      picture: map['picture'],
      category: map['category'],
      description: map['description'],
      businessName: map['businessName'],
      state: map['state'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'AdRequest(id: $id, picture: $picture, category: $category, description: $description, businessName: $businessName, state: $state)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AdRequest &&
        o.id == id &&
        o.picture == picture &&
        o.category == category &&
        o.description == description &&
        o.businessName == businessName &&
        
        o.state == state;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        picture.hashCode ^
        category.hashCode ^
        description.hashCode ^
        businessName.hashCode ^
        
        state.hashCode;
  }
}
