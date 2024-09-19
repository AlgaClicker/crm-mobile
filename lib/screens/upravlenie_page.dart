import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/BLoC/AuthBloc/auth_bloc.dart';

class UpravleniePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upravlenie Dashboard'), actions: [
        IconButton(
            onPressed: () => {}, icon: const Icon(Icons.account_box_sharp)),
        IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(AuthLoginOff());
            })
      ]),
      body: Center(
        child: Text('Welcome, Upravlenie!'),
      ),
    );
  }
}
