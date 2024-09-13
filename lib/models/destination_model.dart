// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// import 'package:collection/collection.dart';

class DestinationModel {
  final String? name;
  final String? location;
  final String? descreption;
  final String? price;
  final String? image;
  // final List<dynamic>? reviews;
  // // final List<dynamic>? stars;
  // final int stars;
  DestinationModel({
    required this.name,
    required this.location,
    required this.descreption,
    required this.price,
    required this.image,
  });

  DestinationModel copyWith({
    String? name,
    String? location,
    String? descreption,
    String? price,
    String? image,
  }) {
    return DestinationModel(
      name: name ?? this.name,
      location: location ?? this.location,
      descreption: descreption ?? this.descreption,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'location': location,
      'descreption': descreption,
      'price': price,
      'image': image,
    };
  }

  factory DestinationModel.fromMap(Map<String, dynamic> map) {
    return DestinationModel(
      name: map['name'] != null ? map['name'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      descreption: map['descreption'] != null ? map['descreption'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DestinationModel.fromJson(String source) =>
      DestinationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DestinationModel(name: $name, location: $location, descreption: $descreption, price: $price, image: $image)';
  }

  @override
  bool operator ==(covariant DestinationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.location == location &&
      other.descreption == descreption &&
      other.price == price &&
      other.image == image;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      location.hashCode ^
      descreption.hashCode ^
      price.hashCode ^
      image.hashCode;
  }
}
