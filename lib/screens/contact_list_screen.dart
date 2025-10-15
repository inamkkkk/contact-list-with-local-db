import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contact_list_app/models/contact.dart';
import 'package:contact_list_app/services/contact_service.dart';
import 'add_contact_screen.dart';

class ContactListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contactService = Provider.of<ContactService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder(future: contactService.getContacts(), builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final contacts = snapshot.data!;
          return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Dismissible(
                  key: Key(contact.name),
                  direction: DismissDirection.endToStart,
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    contactService.deleteContact(contact.id);
                  },
                  child: ListTile(
                    title: Text(contact.name),
                    subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(contact.phoneNumber),
                      Text(contact.email),
                    ]),
                  ),
                );
              });
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContactScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}