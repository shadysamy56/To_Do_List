// ignore_for_file: prefer_const_constructors, unused_import

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/layout/home_layout.dart';
import 'package:to_do_list/modules/counter/CounterScreen.dart';
import 'package:to_do_list/shared/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
