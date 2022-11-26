import 'package:hive/hive.dart';

part 'set_model.g.dart';

@HiveType(typeId: 1)
class SetModel {
  @HiveField(0)
  int index;

  @HiveField(1)
  String workoutType;

  @HiveField(2)
  int weight;

  @HiveField(3)
  int reps;

  SetModel(this.index, this.workoutType, this.weight, this.reps);
}
