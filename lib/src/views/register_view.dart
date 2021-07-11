import 'package:flutter/material.dart';
import 'package:tyba_test_daniel/src/bloc/provider.dart';
import 'package:tyba_test_daniel/src/repositories/usuarios_repository.dart';
import 'package:tyba_test_daniel/src/search/widgets/email_input.dart';
import 'package:tyba_test_daniel/src/search/widgets/password_input.dart';
import 'package:tyba_test_daniel/src/utils/utils.dart';

class RegisterView extends StatelessWidget {
  final userProvider = new UserRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Crea una cuenta', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                EmailInput(bloc: bloc),
                SizedBox(height: 30.0),
                PasswordInput(bloc: bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc)
              ],
            ),
          ),
          FlatButton(
            child: Text('ya tienes cuenta?'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Crear'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.orange,
            textColor: Colors.white,
            onPressed:
                snapshot.hasData ? () => _register(bloc, context) : null);
      },
    );
  }

  _register(LoginBloc bloc, BuildContext context) async {
    final info = await userProvider.newUser(bloc.email, bloc.password);

    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      showAlert(
        context: context,
        message: info['message'],
      );
    }
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondo = Container(
      height: size.height * 0.8,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.orange, Colors.white])),
    );

    return Stack(
      children: <Widget>[
        fondo,
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.fastfood_outlined, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text('Hot Food',
                  style: TextStyle(color: Colors.white, fontSize: 35.0))
            ],
          ),
        )
      ],
    );
  }
}
