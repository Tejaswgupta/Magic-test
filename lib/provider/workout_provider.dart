import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_test_project/models/set_model.dart';

import '../models/workout_model.dart';

class WorkoutProvider extends ChangeNotifier {
  List<WorkoutModel> workouts = [];

  void addWorkout(List<SetModel> sets) {
    workouts.add(WorkoutModel(workouts.length, sets));
    notifyListeners();
  }

  void removeWorkout(int index) {
    workouts.removeWhere((element) => element.index == index);
    notifyListeners();
  }

  void editWorkout(int index, List<SetModel> sets) {
    workouts[index] = WorkoutModel(index, sets);
    notifyListeners();
  }
}

final workoutProvider = ChangeNotifierProvider((ref) => WorkoutProvider());
