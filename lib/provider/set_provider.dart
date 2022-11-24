import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_test_project/models/set_model.dart';

class SetProvider extends ChangeNotifier {
  List<SetModel> get sets => _sets;
  List<SetModel> _sets = [];

  void addSet(SetModel set) {
    _sets.add(set);
    notifyListeners();
  }

  void addSets(List<SetModel> sets) {
    _sets.addAll(sets);
    notifyListeners();
  }

  void removeSet(int index) {
    _sets.removeAt(index);
    notifyListeners();
  }

  void editSet(int index, SetModel model) {
    _sets[index] = model;
    notifyListeners();
  }

  void reset() {
    _sets = [];
    notifyListeners();
  }
}

final setProvider = ChangeNotifierProvider((ref) => SetProvider());
