import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_alga_crm/bloc/application_bloc/application_bloc.dart';
import 'package:mobile_alga_crm/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:mobile_alga_crm/screens/login_page/bloc/login_page_bloc.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage1(),
    );
  }  
}

class LoginPage1 extends StatelessWidget {
  const LoginPage1({super.key});

  //late final ApplicationBloc applicationBloc;
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginPageBloc>(
          create: (context) => LoginPageBloc(),
        ),
      ], 
      child: _LoginPage(),
    );
  }
}


class _LoginPage extends StatelessWidget {

  //_LoginPage({super.key, applicationBloc});

  late final ApplicationBloc applicationBloc;
   
  @override

  Widget build(BuildContext context) {
    return BlocBuilder<LoginPageBloc,LoginPageState>(
      builder: (context,state) {
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                UsernameField(),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                PasswordField(),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                LoginButton(),

              ],
            ),
          ),
        );
      }
    );
  }

}

class InfoBloc extends StatelessWidget {
  const InfoBloc({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(context.read<ApplicationBloc>().state.toString())
      ],
    );
  }
}
class UsernameField extends StatelessWidget {
  
  const UsernameField({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPageBloc, LoginPageState>(
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Имя пользователя',
          ),
          onChanged: (String username) {
            //debugPrint(value);
            context.read<LoginPageBloc>().add(UsernameFieldChange(username));
          },
        );
      },
    );
  }
}

class PasswordField extends StatelessWidget {
    
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPageBloc, LoginPageState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          icon: Icon(Icons.key),
          hintText: 'Password',
        ),
            
        onChanged: (String password){
          context.read<LoginPageBloc>().add(PasswordFieldChange(password));
        },
      );
    });
  }
}


class LoginButton extends StatelessWidget {
  const LoginButton({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPageBloc, LoginPageState>(
      builder: (context, state) {
        
        return state.isValid == true
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: () {
                  debugPrint(state.username);
                  context.read<AuthenticationBloc>().add(AuthenticationEventLogIn(usrname: state.username, password: state.password));
                  //context.read<LoginPageBloc>().add(LoginPageEventSubmitted());
                  //context.read<AuthenticationBloc>().add(AuthenticationEventLogin(username: state.username, password: state.password));
                },
                child: const Text('Вход'),
                
              );
      },
    );
  }
}


class TestButtonPage extends StatelessWidget {
  const TestButtonPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPageBloc, LoginPageState>(
      builder: (context, state) {
        
        return state.isValid == true
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: () {
                  //context.read<AuthenticationBloc>().add(AuthenticationEventGetMe());
                    //context.read<ApplicationBloc>().add(ApplicationEventStart());
                },
                
                child:  Text(context.select((AuthenticationBloc auth) => auth.state.toString())),
                
              );
      },
    );
  }
}

