import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/bloc/auth_bloc/auth_bloc.dart';
import 'package:news_api/pages/sign_in/sign_in.dart';
import 'package:news_api/repositories/auth_repository.dart';

import 'pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
            create: ((context) => AuthBloc(
                authRepository:
                    RepositoryProvider.of<AuthRepository>(context))),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'News',
              home: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return HomePage();
                  }
                  return const SignIn();
                },
              ),
            )));
  }
}
