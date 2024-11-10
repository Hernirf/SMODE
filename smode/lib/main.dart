import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smode/blocs/auth/auth_bloc.dart';
import 'package:smode/blocs/deteksi/deteksi_bloc.dart';
import 'package:smode/blocs/vehicle/vehicle_bloc.dart';
import 'package:smode/firebase_options.dart';
import 'package:smode/ui/pages/auth/auth.dart';
import 'package:smode/ui/pages/home/home.dart';
import 'package:smode/ui/pages/spash/spalsh.dart';


final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => VehicleBloc()),
        BlocProvider(create: (context) => DeteksiBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SMODE',
        navigatorKey: navigatorKey,
        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
