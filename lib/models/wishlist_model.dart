// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WishList {
  final String uid;
  final String did;
  WishList({
    required this.uid,
    required this.did,
  });

  WishList copyWith({
    String? uid,
    String? did,
  }) {
    return WishList(
      uid: uid ?? this.uid,
      did: did ?? this.did,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'did': did,
    };
  }

  factory WishList.fromMap(Map<String, dynamic> map) {
    return WishList(
      uid: map['uid'] as String,
      did: map['did'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WishList.fromJson(String source) => WishList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WishList(uid: $uid, did: $did)';

  @override
  bool operator ==(covariant WishList other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.did == did;
  }

  @override
  int get hashCode => uid.hashCode ^ did.hashCode;
}
