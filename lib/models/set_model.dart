import 'package:hive/hive.dart';

part 'set_model.g.dart';

@HiveType(typeId: 1)
class SetModel {
  @HiveField(0)
  final int index;

  @HiveField(1)
  final String workoutType;

  @HiveField(2)
  final int weight;

  @HiveField(3)
  final int reps;

  SetModel(this.index, this.workoutType, this.weight, this.reps);
}
