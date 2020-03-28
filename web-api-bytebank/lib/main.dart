import 'package:flutter/material.dart';
import 'package:newbytebank/api/webclient.dart';
import 'package:newbytebank/models/contact.dart';
import 'package:newbytebank/models/transaction.dart';
import 'package:newbytebank/screens/dashboard.dart';

void main() {
  runApp(Newbytebank());
  save(Transaction(200.0, Contact(0, 'Rams', 4000))).then((transaction) => print(transaction));
}

class Newbytebank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Dashboard(),
    );
  }
}


