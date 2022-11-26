import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:magic_test_project/models/set_model.dart';
import 'package:magic_test_project/screens/workout_screen.dart';

class WorkoutListScreen extends ConsumerStatefulWidget {
  static const id = 'WorkoutListScreen';

  const WorkoutListScreen({super.key});

  @override
  ConsumerState<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends ConsumerState<WorkoutListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Workouts'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueListenableBuilder<Box>(
            valueListenable: Hive.box('magic').listenable(),
            builder: (context, box, widget) {
              if (box.isEmpty) {
                return const Center(child: Text('No workouts yet'));
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    return WorkoutTile(
                      index: index,
                      sets: box.getAt(index)!.cast<SetModel>(),
                    );
                  },
                ),
              );
            },
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
                //TODO : Remove workout
                // provider.removeWorkout(widget.index);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
