
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mywalletapp/features/home/cubit/home_cubit.dart';
import 'package:mywalletapp/features/home/data/data_sources/home_api_service.dart';
import 'package:mywalletapp/features/home/data/models/splash_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => HomeCubit(HomeApiService())..getProducts(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}