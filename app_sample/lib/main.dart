import 'package:app_sample/present/bloc/tips_bloc.dart';
import 'package:app_sample/present/view/calculator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const TipsApp());
}

class TipsApp extends StatelessWidget {
  const TipsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TipsCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tips Calculator',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 12, 180, 76)),
          useMaterial3: true,
        ),
        home: const CalculatorPage(),
      ),
    );
  }
}
