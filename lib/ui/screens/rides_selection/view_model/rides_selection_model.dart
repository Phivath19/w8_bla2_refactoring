import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/rides_selection_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../data/repositories/ride/ride_repository.dart';
import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../../ui/state/ride_preferences_state.dart';

class RidesSelectionViewModel extends ChangeNotifier {
  final RidePreferencesState _ridePreferencesState;
  final RideRepository _rideRepository;

  List<Ride> _matchingRides = [];

  RidesSelectionViewModel({
    required RidePreferencesState ridePreferenceState,
    required RideRepository rideRepository,
  }) : _ridePreferencesState = ridePreferenceState,
       _rideRepository = rideRepository {
    _ridePreferencesState.addListener(_onStateChanged);

    _fetchRides();
  }
  void _onStateChanged() {
    _fetchRides();
  }

  Future<void> _fetchRides() async {
    if (_ridePreferencesState.currentPreference != null) {
      _matchingRides = await _rideRepository.getRidesFor(
        _ridePreferencesState.currentPreference!,
      );
    } else {
      _matchingRides = [];
    }
    notifyListeners();
  }

  RidePreference? get currentPreference =>
      _ridePreferencesState.currentPreference!;
  List<Ride> get matchingRides => _matchingRides;
  Future<void> selectPreference(RidePreference ridepreference) async {
    await _ridePreferencesState.selectPreference(ridepreference);
  }

  @override
  void dispose() {
    _ridePreferencesState.removeListener(_onStateChanged);
    super.dispose();
  }
}
