import 'package:flutter/material.dart';
import 'package:flutter_messagerie/pages/register_page.dart';
import 'package:flutter_messagerie/pages/rooms_page.dart';
import 'package:flutter_messagerie/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getInitialSession();
    super.initState();
  }

  Future<void> getInitialSession() async {
    await Future.delayed(Duration.zero);

    try {
      final session = await SupabaseAuth.instance.initialSession;
      if (session == null) {
        Navigator.of(context)
            .pushAndRemoveUntil(RegisterPage.route(), (_) => false);
      } else {
        Navigator.of(context)
            .pushAndRemoveUntil(RoomsPage.route(), (_) => false);
      }
    } catch (_) {
      context.showErrorSnackBar(
        message: 'Erreur de la session',
      );
      Navigator.of(context)
          .pushAndRemoveUntil(RegisterPage.route(), (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
