import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_messagerie/pages/login_page.dart';
import 'package:flutter_messagerie/pages/rooms_page.dart';
import 'package:flutter_messagerie/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Page d'inscription
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.isRegistering}) : super(key: key);

  static Route<void> route({bool isRegistering = false}) {
    return MaterialPageRoute(
      builder: (context) => RegisterPage(isRegistering: isRegistering),
    );
  }

  final bool isRegistering;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();

    bool haveNavigated = false;
    _authSubscription = supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      if (session != null && !haveNavigated) {
        haveNavigated = true;
        Navigator.of(context).pushReplacement(RoomsPage.route());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _authSubscription.cancel();
  }

  Future<void> _signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    final email = _emailController.text;
    final password = _passwordController.text;
    final username = _usernameController.text;
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'username': username},
        emailRedirectTo: 'io.supabase.chat://login',
      );
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      debugPrint(error.toString());
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S'inscrire"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: formPadding,
          children: [
            TextFormField(
              controller: _usernameController,
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                label: Text('Nom'),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Recquis';
                }
                if (val.length < 3) {
                  return "3 caractères sont recquis au minimum pour définir votre nom d'utilisateur";
                }
                return null;
              },
            ),
            spacer,
            TextFormField(
              controller: _emailController,
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Recquis';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            spacer,
            TextFormField(
              controller: _passwordController,
              cursorColor: Colors.blue,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text('Mot de passe'),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Recquis';
                }
                if (val.length < 10) {
                  return '10 caractères sont recquis au minimum pour définir votre mot de passe';
                }
                return null;
              },
            ),
            spacer,
            ElevatedButton(
              onPressed: _isLoading ? null : _signUp,
              child: const Text("S'inscrire"),
            ),
            spacer,
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(LoginPage.route());
                },
                child: const Text("J'ai déjà un compte"))
          ],
        ),
      ),
    );
  }
}
