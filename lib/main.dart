import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_using_bloc/cubit/auth_cubit/auth_cubit.dart';
import 'package:phone_auth_using_bloc/cubit/auth_cubit/auth_state.dart';
import 'package:phone_auth_using_bloc/firebase_options.dart';
import 'package:phone_auth_using_bloc/screens/home_screen.dart';
import 'package:phone_auth_using_bloc/screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (oldState, newState) {
              return oldState is AuthInitialState;
            },
            builder: (context, state) {
              if (state is AuthLoggedInState) {
                return HomeScreen();
              } else if (state is AuthLoggedOutState) {
                return SignInScreen();
              } else {
                return Scaffold();
              }
            },
          )),
    );
  }
}
