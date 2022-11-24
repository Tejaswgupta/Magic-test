import 'package:hive/hive.dart';
import 'package:magic_test_project/models/set_model.dart';

part 'workout_model.g.dart';

@HiveType(typeId: 2)
class WorkoutModel {
  @HiveField(0)
  final int index;
  @HiveField(1)
  final List<SetModel> sets;

  WorkoutModel(this.index, this.sets);
}
