import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_messagerie/cubits/profiles/profiles_cubit.dart';
import 'package:flutter_messagerie/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_messagerie/pages/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qveernrkjdvrbqvtvdhf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF2ZWVybnJramR2cmJxdnR2ZGhmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMTYxOTUwNSwiZXhwIjoyMDE3MTk1NTA1fQ.Zok5mjyxLOx3_3FrDS54naNHYgHY0BoqubvhLsCtlAo',
    authCallbackUrlHostname: 'login',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfilesCubit>(
      create: (context) => ProfilesCubit(),
      child: MaterialApp(
        title: 'Flutter Messagerie',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const SplashPage(),
      ),
    );
  }
}
