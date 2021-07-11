import 'package:flutter/material.dart';

void showAlert({
  BuildContext context,
  String message,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Información incorrecta'),
      content: Text(
        message,
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Ok'),
          textColor: Colors.orange,
        ),
      ],
    ),
  );
}
