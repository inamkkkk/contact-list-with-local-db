import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:contact_list_app/models/contact.dart';
import 'package:uuid/uuid.dart';

class ContactService extends ChangeNotifier {
  final String _boxName = 'contacts';

  Future<List<Contact>> getContacts() async {
    final box = await Hive.openBox(_boxName);
    List<Contact> contacts = [];
    for (var key in box.keys) {
      var data = box.get(key);
      contacts.add(Contact(
          id: key,
          name: data['name'],
          phoneNumber: data['phoneNumber'],
          email: data['email']));
    }
    return contacts;
  }

  Future<void> addContact(String name, String phoneNumber, String email) async {
    final box = await Hive.openBox(_boxName);
    var id = Uuid().v4();
    await box.put(id, {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    });
    notifyListeners();
  }

  Future<void> deleteContact(String id) async {
    final box = await Hive.openBox(_boxName);
    await box.delete(id);
    notifyListeners();
  }
}