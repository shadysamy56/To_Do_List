// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/shared/cubit/states.dart';
import 'package:to_do_list/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:to_do_list/modules/done_tasks/done_tasks_screen.dart';
import 'package:to_do_list/modules/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  late Database db;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    print(currentIndex);
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() {
    openDatabase(
      'to_do.db',
      version: 1,
      onCreate: (db, version) {
        print('database created');
        db
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error found when creating table ${error.toString()}');
        });
      },
      onOpen: (db) {
        print('database opened');
        getDataFromDatabase(db);
      },
    ).then((value) {
      db = value;
      emit(AppCreateDataBaseState());
    });
  }

  Future insertToDatabase({
    required title,
    required time,
    required date,
  }) async {
    await db.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, time, date, status) VALUES("$title", "$time", "$date", "new")')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDataBaseState());
        getDataFromDatabase(db);
      }).catchError((error) {
        print('error found when inserting ${error.toString()}');
      });
      return null;
    });
  }

  void getDataFromDatabase(db) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDataBaseLoadingState());
    db.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach(
        (element) {
          if (element['status'] == 'new') {
            newTasks.add(element);
          } else if (element['status'] == 'done') {
            doneTasks.add(element);
          } else {
            archivedTasks.add(element);
          }
        },
      );

      emit(AppGetDataBaseState());
    });
  }

  void updateDatainDatabase({
    required String status,
    required int id,
  }) async {
    db.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [
      status,
      id,
    ]).then((value) {
      getDataFromDatabase(db);
      emit(AppUpdateDataBaseState());
    });
  }

  void deleteDataFromDatabase({
    required int id,
  }) async {
    db.rawUpdate('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(db);
      emit(AppDeleteDataBaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheet({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
