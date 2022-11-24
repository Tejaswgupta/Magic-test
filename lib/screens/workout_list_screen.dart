import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_test_project/models/set_model.dart';
import 'package:magic_test_project/screens/workout_screen.dart';

import '../provider/workout_provider.dart';

class WorkoutListScreen extends ConsumerStatefulWidget {
  static const id = 'WorkoutListScreen';

  const WorkoutListScreen({super.key});

  @override
  ConsumerState<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends ConsumerState<WorkoutListScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(workoutProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Workouts'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              children: provider.workouts
                  .map((value) =>
                      WorkoutTile(index: value.index, sets: value.sets))
                  .toList(),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, WorkoutScreen.id);
              },
              child: const Text('Add Workout'),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutTile extends ConsumerStatefulWidget {
  final int index;
  final List<SetModel> sets;

  const WorkoutTile({
    super.key,
    required this.index,
    required this.sets,
  });

  @override
  ConsumerState<WorkoutTile> createState() => _WorkoutTileState();
}

class _WorkoutTileState extends ConsumerState<WorkoutTile> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(workoutProvider);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        children: [
          Text(
            'Workout ${widget.index}',
            style: const TextStyle(fontSize: 18),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => WorkoutScreen(
                          index: widget.index,
                          sets: widget.sets,
                        )),
                  ),
                );
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                provider.removeWorkout(widget.index);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
