import 'package:edumate/modals/modal_fit.dart';
import 'package:edumate/models/contact.dart';
import 'package:edumate/resources/firestore_methods.dart';
import 'package:edumate/utils/utils.dart';
import 'package:edumate/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomCard extends StatefulWidget {
  final Contact contact;

  const CustomCard({Key? key, required this.contact}) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  void deleteContact(String contactId) async {
    await _firestoreMethods.deleteContact(context, contactId);
    if (!mounted) return;
    showSnackBar(context, 'Contact deleted successfully!');
    // Navigator.of(context).pop();
  }

  void editContact(String contactId) async {
    await _firestoreMethods.editContact(
      context,
      contactId,
      _nameController.text,
      _numberController.text,
    );

    if (!mounted) return;
    _numberController.clear();
    _nameController.clear();
    showSnackBar(context, 'Contact updated successfully!');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 3.0,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://api.dicebear.com/5.x/lorelei/jpg?seed=${widget.contact.name}",
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        widget.contact.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          FontAwesomeIcons.phone,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          widget.contact.number,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(2.0),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.white,
                            ),
                            foregroundColor: MaterialStateProperty.all(
                              Colors.black,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            _nameController.text = widget.contact.name;
                            _numberController.text = widget.contact.number;
                            showMaterialModalBottomSheet(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        textEditingController:
                                            _numberController,
                                        textColor: Colors.black,
                                        accentColor: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(2.0),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Colors.black,
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                            Colors.white,
                                          ),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              side: const BorderSide(
                                                color: Colors.black,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          editContact(widget.contact.uid);
                                        },
                                        child: const Text(
                                          'Save',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Edit',
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(2.0),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.red,
                            ),
                            foregroundColor: MaterialStateProperty.all(
                              Colors.white,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            deleteContact(widget.contact.uid);
                          },
                          child: const Text(
                            'Delete',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
