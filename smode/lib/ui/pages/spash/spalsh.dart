import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smode/blocs/auth/auth_bloc.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  splashPageStart() {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      context.read<AuthBloc>().add(AuthGetCurrentUser());
    });
  }

  @override
  void initState() {
    super.initState();
    splashPageStart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          }

          if (state is AuthFailed) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          }
      },
      child: Scaffold(
          backgroundColor: const Color(0xFFF6F1F1),
          body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(40, 40, 40, 40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
