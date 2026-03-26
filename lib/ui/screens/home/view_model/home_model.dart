import 'package:flutter/material.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../../ui/state/ride_preferences_state.dart';

class HomeViewModel extends ChangeNotifier {
  final RidePreferencesState _ridePreferencesState;

  HomeViewModel({required RidePreferencesState ridePreferencesState})
    : _ridePreferencesState = ridePreferencesState {
    _ridePreferencesState.addListener(_onStateChanged);
  }

  void _onStateChanged() {
    notifyListeners();
  }

  RidePreference? get currentPreference =>
      _ridePreferencesState.currentPreference;

  List<RidePreference> get history => _ridePreferencesState.history;

  Future<void> selectPreference(RidePreference preference) async {
    await _ridePreferencesState.selectPreference(preference);
  }

  @override
  void dispose() {
    _ridePreferencesState.removeListener(_onStateChanged);
    super.dispose();
  }
}
