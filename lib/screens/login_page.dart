import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/BLoC/AuthBloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String? errorMessage;

  LoginPage({this.errorMessage});

  @override
  Widget build(BuildContext context) {
    //_usernameController.text = "master24";
    //_passwordController.text = "master24";
    return Scaffold(
      appBar: AppBar(
        title: Text('Авторизация'),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.help),
            tooltip: "Помощь",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Имя пользователя'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  AuthLoginRequested(
                    _usernameController.text,
                    _passwordController.text,
                  ),
                );
              },
              child: const Text('Вход'),
            ),
          ],
        ),
      ),
    );
  }
}
