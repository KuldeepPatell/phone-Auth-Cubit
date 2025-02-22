import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_using_bloc/cubit/auth_cubit/auth_cubit.dart';
import 'package:phone_auth_using_bloc/cubit/auth_cubit/auth_state.dart';
import 'package:phone_auth_using_bloc/screens/sign_in_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: SafeArea(
          child: Container(
        child: Center(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoggedOutState) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => SignInScreen()));
              }
            },
            builder: (context, state) {
              return CupertinoButton(
                  child: Text("Log Out"),
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).logOut();
                  });
            },
          ),
        ),
      )),
    );
  }
}
