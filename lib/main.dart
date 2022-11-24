import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:magic_test_project/models/set_model.dart';
import 'package:magic_test_project/models/workout_model.dart';
import 'package:magic_test_project/screens/workout_list_screen.dart';
import 'package:magic_test_project/screens/workout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SetModelAdapter());
  Hive.registerAdapter(WorkoutModelAdapter());
  await Hive.openBox('magic');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WorkoutListScreen.id,
      routes: {
        WorkoutScreen.id: (context) => const WorkoutScreen(),
        WorkoutListScreen.id: (context) => const WorkoutListScreen(),
      },
    );
  }
}
