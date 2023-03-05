import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumate/models/contact.dart';
import 'package:edumate/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveContact(
    BuildContext context,
    String name,
    String number,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (name.isNotEmpty && number.isNotEmpty) {
        if (int.tryParse(number) == null) {
          showSnackBar(context, "Number must be integer.");
          return;
        }
        final collectionRef = _firestore.collection('contacts');
        final documentRef = collectionRef
            .doc(); // generate a new document reference with a unique ID
        Contact contact = Contact(
          name: name,
          number: number,
          userId: user!.uid,
          uid: documentRef.id,
        ); // copy the Contact with the generated ID
        return await documentRef.set(
          contact.toMap(),
        );
      } else {
        showSnackBar(
          context,
          "Please enter all the fields",
        );
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> editContact(
    BuildContext context,
    String contactId,
    String name,
    String number,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (name.isNotEmpty && number.isNotEmpty) {
        if (int.tryParse(number) == null) {
          showSnackBar(context, "Number must be integer.");
          return;
        }

        return await _firestore.collection('contacts').doc(contactId).update({
          'name': name,
          'number': number,
        });
      } else {
        showSnackBar(
          context,
          "Please enter all the fields",
        );
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> deleteContact(BuildContext context, String contactId) async {
    try {
      return await _firestore.collection('contacts').doc(contactId).delete();
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      showSnackBar(context, e.message!);
    }
  }
}
