class Contact {
  final String name;
  final String number;
  final String userId;
  final String uid;

  Contact({
    required this.name,
    required this.number,
    required this.userId,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
      'userId': userId,
      'uid': uid,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      name: map['name'],
      number: map['number'],
      userId: map['userId'],
      uid: map['uid'],
    );
  }
}
