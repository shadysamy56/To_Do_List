// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, avoid_print, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/modules/counter/Cubit/cubit.dart';
import 'package:to_do_list/modules/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child:
          BlocConsumer<CounterCubit, CounterStates>(listener: (context, state) {
        if (state is CounterPlusState) {
          // print('Plus State ${state.counter}');
        }
        if (state is CounterMinusState) {
          // print('Minus State ${state.counter}');
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Counter'),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      CounterCubit.get(context).minus();
                    },
                    child: Text(
                      'Minus',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    '${CounterCubit.get(context).counter}',
                    style:
                        TextStyle(fontSize: 50.0, fontWeight: FontWeight.w900),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      CounterCubit.get(context).plus();
                    },
                    child: Text(
                      'Plus',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600),
                    )),
              ],
            ),
          ),
        );
      }),
    );
  }
}
