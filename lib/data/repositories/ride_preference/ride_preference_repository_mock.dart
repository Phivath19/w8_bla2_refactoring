import 'package:blabla/model/ride/ride.dart';

import '../../../data/dummy_data.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../ride_preference/ride_preference_repository.dart';

class RidePreferenceRepositoryMock implements RidePreferenceRepository {
  final List<RidePreference> _history = List.from(fakeRidePrefs);
  RidePreference? _currentPreference;
  @override
  Future<List<RidePreference>> getHistory() async {
    return _history;
  }

  @override
  Future<RidePreference?> getCurrentPreference() async {
    return _currentPreference;
  }

  @override
  Future<void> savePreference(RidePreference preference) async {
    if (preference != _currentPreference) {
      _currentPreference = preference;
      _history.add(preference);
    }
  }
}
