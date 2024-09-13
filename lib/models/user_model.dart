// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String profilePic;
  final String? location;
  final String uid;
  final String email;
  final List<String> wishList;
  UserModel({
    required this.name,
    required this.profilePic,
    this.location,
    required this.uid,
    required this.email,
    required this.wishList,
  });

  UserModel copyWith({
    String? name,
    String? profilePic,
    String? location,
    String? uid,
    String? email,
    List<String>? wishList,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      location: location ?? this.location,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      wishList: wishList ?? this.wishList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'location': location,
      'uid': uid,
      'email': email,
      'wishList': wishList,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      location: map['location'] != null ? map['location'] as String : null,
      uid: map['uid'] as String,
      email: map['email'] as String,wishList: List<String>.from((map['wishList'] as List<dynamic>).map((e) => e as String)),
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, profilePic: $profilePic, location: $location, uid: $uid, email: $email, wishList: $wishList)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.profilePic == profilePic &&
      other.location == location &&
      other.uid == uid &&
      other.email == email &&
      listEquals(other.wishList, wishList);
  }

  @override
  int get hashCode {
    return name.hashCode ^
      profilePic.hashCode ^
      location.hashCode ^
      uid.hashCode ^
      email.hashCode ^
      wishList.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
