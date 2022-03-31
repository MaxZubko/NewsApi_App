import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/pages/home_page.dart';
import 'package:email_validator/email_validator.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/auth_bloc/auth_event.dart';
import '../../bloc/auth_bloc/auth_state.dart';
import '../../constants.dart';
import '../sign_in/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKeyAuth = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _hidePass = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenicated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(state.error, style: const TextStyle(color: primaryColor)),
            backgroundColor: secondaryColor,
          ));
        }
      },
      builder: (context, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is UnAutthenticated) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w400,
                        color: secondaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Form(
                        key: _formKeyAuth,
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                    labelText: "Email".toUpperCase(),
                                    labelStyle: const TextStyle(
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w700),
                                    enabledBorder: kUnderlineInputBorder,
                                    focusedBorder: kUnderlineInputBorder,
                                    focusedErrorBorder:
                                        kUnderlineInputBorder.copyWith(
                                            borderSide: const BorderSide(
                                                color: Colors.red)),
                                    errorBorder: kUnderlineInputBorder),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null &&
                                          !EmailValidator.validate(value)
                                      ? 'Enter a valid email'
                                      : null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                obscureText: _hidePass,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      color: secondaryColor,
                                      icon: Icon(_hidePass
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _hidePass = !_hidePass;
                                        });
                                      },
                                    ),
                                    labelText: "Password".toUpperCase(),
                                    labelStyle: const TextStyle(
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w700),
                                    enabledBorder: kUnderlineInputBorder,
                                    focusedBorder: kUnderlineInputBorder,
                                    focusedErrorBorder:
                                        kUnderlineInputBorder.copyWith(
                                            borderSide: const BorderSide(
                                                color: Colors.red)),
                                    errorBorder: kUnderlineInputBorder),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value.length < 6
                                      ? "Enter min. 6 characters"
                                      : null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              height: 50.0,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  _createAccountWithEmailAndPassword(context);
                                },
                                child: Text(
                                  'Sign Up'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: secondaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()),
                          );
                        },
                        child: const Text(
                          "Already have an account?",
                          style: TextStyle(color: secondaryColor),
                        )),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    ));
  }

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKeyAuth.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
          _emailController.text,
          _passwordController.text,
        ),
      );
    }
  }
}
