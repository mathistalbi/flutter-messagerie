import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

const preloader = Center(child: CircularProgressIndicator(color: Colors.blue));

const spacer = SizedBox(width: 16, height: 16);

const formPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 16);

const unexpectedErrorMessage = "Une erreur inattendue s'est produite";

final appTheme = ThemeData.light().copyWith(
  primaryColorDark: Colors.blue,
  appBarTheme: const AppBarTheme(
    elevation: 1,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
  ),
  primaryColor: Colors.blue,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.blue,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: const TextStyle(
      color: Colors.blue,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 2,
      ),
    ),
    focusColor: Colors.blue,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.blue,
        width: 2,
      ),
    ),
  ),
);

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}
