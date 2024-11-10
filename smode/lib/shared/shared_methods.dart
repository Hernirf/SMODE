import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

showErrorDialog(BuildContext context, String message) {
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Error"),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

formattedDate(String originalDate) {
  DateTime dateTime = DateTime.parse(originalDate);
  String formattedDate = DateFormat('dd-MM-yyyy, HH:mm').format(dateTime);
  return formattedDate;
}