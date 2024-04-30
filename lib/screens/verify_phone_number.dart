import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_using_bloc/cubit/auth_cubit/auth_cubit.dart';
import 'package:phone_auth_using_bloc/cubit/auth_cubit/auth_state.dart';
import 'package:phone_auth_using_bloc/screens/home_screen.dart';

// ignore: must_be_immutable
class VerifyPhoneNumberScreen extends StatelessWidget {
  // const VerifyPhoneNumberScreen({super.key});

  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify phone number"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                TextField(
                  controller: otpController,
                  maxLength: 6,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "6-Digit OTP",
                      counterText: ""),
                ),
                SizedBox(height: 10),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoggedInState) {
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    } else if (state is AuthErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Invalid OTP"),
                        duration: Duration(milliseconds: 2000),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CupertinoButton(
                        child: Text("Verify"),
                        onPressed: () {
                          BlocProvider.of<AuthCubit>(context)
                              .verifyOTP(otpController.text);
                        },
                        color: Colors.blue,
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
