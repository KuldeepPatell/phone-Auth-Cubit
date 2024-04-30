import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_using_bloc/cubit/auth_cubit/auth_cubit.dart';
import 'package:phone_auth_using_bloc/cubit/auth_cubit/auth_state.dart';
import 'package:phone_auth_using_bloc/screens/verify_phone_number.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  // const SignInScreen({super.key});

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In with phone"),
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
                    controller: phoneController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Phone Number",
                        counterText: ""),
                  ),
                  SizedBox(height: 10),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthCodeSentState) {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    VerifyPhoneNumberScreen()));
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
                          child: Text("Sign In"),
                          onPressed: () {
                            String phoneNumber = "+91" + phoneController.text;
                            BlocProvider.of<AuthCubit>(context)
                                .sendOTP(phoneNumber);
                          },
                          color: Colors.blue,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
