import 'package:blabla/model/ride_pref/ride_pref.dart';

import '../../../data/dummy_data.dart';
import '../../../model/ride/ride.dart';
import '../ride/ride_repository.dart';

class RideRepositoryMock implements RideRepository {
  @override
  Future<List<Ride>> getRidesFor(RidePreference preferences) async {
    return fakeRides
        .where(
          (ride) =>
              ride.departureLocation == preferences.departure &&
              ride.arrivalLocation == preferences.arrival &&
              ride.availableSeats >= preferences.requestedSeats,
        )
        .toList();
  }
}
