import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:magic_test_project/provider/set_provider.dart';

import '../models/set_model.dart';

const List<String> workoutTypes = <String>[
  'Barbell row',
  'Bench press',
  'Shoulder press',
  'Deadlift',
  'Squat'
];

class WorkoutScreen extends ConsumerStatefulWidget {
  static const id = 'WorkoutScreen';
  final List<SetModel>? sets;
  final int? index;

  const WorkoutScreen({
    super.key,
    this.sets,
    this.index,
  });

  @override
  ConsumerState<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<WorkoutScreen> {
  @override
  void initState() {
    if (widget.sets != null) {
      Future.delayed(Duration.zero, () {
        ref.read(setProvider).addSets(widget.sets!);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(setProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Edit Workout'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          int index = provider.sets.length;
          ref
              .read(setProvider)
              .addSet(SetModel(index++, workoutTypes.first, 0, 0));
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: provider.sets
                  .map<Widget>((value) => EditWorkoutScreenTile(model: value))
                  .toList(),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                var box = Hive.box('magic');
                if (widget.index != null) {
                  box.putAt(widget.index!, provider.sets);
                } else {
                  box.add(provider.sets);
                }

                provider.reset();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          )
        ],
      ),
    );
  }
}

class EditWorkoutScreenTile extends ConsumerStatefulWidget {
  final SetModel model;

  const EditWorkoutScreenTile({
    super.key,
    required this.model,
  });

  @override
  ConsumerState<EditWorkoutScreenTile> createState() =>
      _EditWorkoutScreenTileState();
}

class _EditWorkoutScreenTileState extends ConsumerState<EditWorkoutScreenTile> {
  late String dropdownValue;

  late TextEditingController _weightController;
  late TextEditingController _repsController;

  final _padding = const EdgeInsets.symmetric(horizontal: 10);

  @override
  void initState() {
    _weightController =
        TextEditingController(text: widget.model.weight.toString());
    _repsController = TextEditingController(text: widget.model.reps.toString());
    dropdownValue = widget.model.workoutType;

    super.initState();
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: _padding,
          child: Text(
            'Set ${widget.model.index}',
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: _padding,
          child: DropdownButton<String>(
            isDense: true,
            value: dropdownValue,
            items: workoutTypes.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              ref.read(setProvider).editSet(
                    widget.model.index,
                    SetModel(widget.model.index, value!, 0, 0),
                  );
              setState(() {
                dropdownValue = value;
              });
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: _padding,
            child: TextField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Weight',
              ),
              controller: _weightController,
              onChanged: (value) {
                ref.read(setProvider).editSet(
                      widget.model.index,
                      SetModel(
                        widget.model.index,
                        dropdownValue,
                        int.parse(value),
                        int.parse(_repsController.text),
                      ),
                    );
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: _padding,
            child: TextField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Reps',
              ),
              controller: _repsController,
              onChanged: (value) {
                ref.read(setProvider).editSet(
                      widget.model.index,
                      SetModel(
                        widget.model.index,
                        dropdownValue,
                        int.parse(_weightController.text),
                        int.parse(value),
                      ),
                    );
              },
            ),
          ),
        ),
      ],
    );
  }
}
