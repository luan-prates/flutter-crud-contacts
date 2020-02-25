import 'package:flutter/material.dart';
import 'package:newbytebank/database/app_database.dart';
import 'package:newbytebank/models/contact.dart';

class ContactForm extends StatefulWidget {

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameControler = TextEditingController();
  final TextEditingController _accountNumberControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameControler,
              decoration: InputDecoration(labelText: 'Full name'),
              style: TextStyle(fontSize: 24.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumberControler,
                decoration: InputDecoration(labelText: 'Account number'),
                style: TextStyle(
                  fontSize: 24.0,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text('Create'),
                  onPressed: (){
                    final String name = _nameControler.text;
                    final int accountNumber = int.tryParse(_accountNumberControler.text);
                    final Contact newContact = Contact(0, name, accountNumber);
                    save(newContact).then((id) => Navigator.pop(context, newContact));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
