import 'package:tyba_test_daniel/src/bloc/provider.dart';

import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {

  final LoginBloc bloc;
  const PasswordInput({Key key,
  this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.vpn_key_outlined, color: Colors.orange),
                labelText: 'Contraseña',
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }
}