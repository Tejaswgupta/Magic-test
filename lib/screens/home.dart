//! Added for Bottom Navigation Bar

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:magic_test_project/screens/workout_list_screen.dart';
// import 'package:magic_test_project/screens/workout_screen.dart';

// class HomeScreen extends StatefulWidget {
//   static const id = 'HomeScreen';

//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   static const List<Widget> _children = <Widget>[
//     WorkoutListScreen(),
//     WorkoutScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _children[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (value) {
//           setState(() {
//             _selectedIndex = value;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.fitness_center),
//             label: 'Edit Workout',
//           ),
//         ],
//       ),
//     );
//   }
// }
