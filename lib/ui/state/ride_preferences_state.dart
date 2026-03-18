import 'package:flutter/material.dart';

import '../../data/repositories/ride_preference/ride_preference_repository.dart';
import '../../model/ride_pref/ride_pref.dart';

///
/// Global state for ride preferences
/// - Holds current selected preference
/// - Holds history of preferences
/// - Uses RidePreferenceRepository
///
class RidePreferencesState extends ChangeNotifier {
  final RidePreferenceRepository _repository;

  RidePreference? _currentPreference;
  List<RidePreference> _history = [];

  static const int maxAllowedSeats = 8;

  RidePreferencesState({required RidePreferenceRepository repository})
    : _repository = repository {
    _init();
  }

  // Getters
  RidePreference? get currentPreference => _currentPreference;
  List<RidePreference> get history => _history;

  // Load initial data from repository
  Future<void> _init() async {
    _history = await _repository.getHistory();
    _currentPreference = await _repository.getCurrentPreference();
    notifyListeners();
  }

  // Select a new preference
  Future<void> selectPreference(RidePreference preference) async {
    if (preference != _currentPreference) {
      // Update current preference
      _currentPreference = preference;

      // Save to repository (also updates history)
      await _repository.savePreference(preference);

      // Reload history
      _history = await _repository.getHistory();

      // Notify listeners
      notifyListeners();
    }
  }
}
