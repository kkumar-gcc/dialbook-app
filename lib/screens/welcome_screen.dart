import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumate/modals/modal_fit.dart';
import 'package:edumate/models/contact.dart';
import 'package:edumate/providers/google_provider.dart';
import 'package:edumate/resources/firestore_methods.dart';
import 'package:edumate/utils/utils.dart';
import 'package:edumate/widgets/custom_card.dart';
import 'package:edumate/widgets/custom_textfield.dart';
import 'package:edumate/widgets/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = "/welcome";
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  void saveContact() async {
    await _firestoreMethods.saveContact(
        context, _nameController.text, _numberController.text);

    if (!mounted) return;
    _numberController.clear();
    _nameController.clear();
    showSnackBar(context, 'Contact created successfully!');
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        elevation: 3.0,
        title: const Text(
          "DialBook",
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.arrowRightFromBracket,
            ),
            tooltip: 'logout',
            onPressed: () {
              final provider = Provider.of<GoogleSignInProvider>(
                context,
                listen: false,
              );
              provider.logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: 12.0,
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Contacts",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => showMaterialModalBottomSheet(
                    expand: false,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => ModalFit(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22.0,
                          vertical: 10.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              labelText: 'Name',
                              textEditingController: _nameController,
                              textColor: Colors.black,
                              accentColor: Colors.black,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              labelText: 'Number',
                              textEditingController: _numberController,
                              textColor: Colors.black,
                              accentColor: Colors.black,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(2.0),
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.black,
                                ),
                                foregroundColor: MaterialStateProperty.all(
                                  Colors.white,
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: saveContact,
                              child: const Text(
                                'Save',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  tooltip: "Add new contact",
                  icon: const Icon(
                    FontAwesomeIcons.plus,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<dynamic>(
              stream: FirebaseFirestore.instance
                  .collection('contacts')
                  .where('userId', isEqualTo: user!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingIndicator();
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      Contact contact = Contact.fromMap(
                        snapshot.data.docs[index].data(),
                      );
                      return CustomCard(contact: contact);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
