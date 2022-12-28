// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/shared/components/components.dart';
import 'package:to_do_list/shared/cubit/states.dart';

import '../../shared/cubit/cubit.dart';

class DoneTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).doneTasks;

        if (tasks.isNotEmpty) {
          return ListView.separated(
            itemBuilder: ((context, index) =>
                BuildTaskItem(tasks[index], context)),
            separatorBuilder: ((context, index) => Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                )),
            itemCount: tasks.length,
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(
                  Icons.menu,
                  color: Colors.grey,
                  size: 100.0,
                ),
                Text(
                  'No Tasks Yet , Please Add Some Tasks',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
