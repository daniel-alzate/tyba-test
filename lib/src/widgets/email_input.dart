import 'package:flutter/material.dart';
import 'package:tyba_test_daniel/src/bloc/login_bloc.dart';

class EmailInput extends StatelessWidget {

  final LoginBloc bloc;

  const EmailInput({Key key,
  this.bloc,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.email_outlined, color: Colors.orange),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }
}