import 'package:flutter/material.dart';
import '../../../../model/ride/ride.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../../utils/animations_util.dart';
import '../../../theme/theme.dart';
import '../view_model/rides_selection_model.dart';
import 'ride_preference_modal.dart';
import 'rides_selection_header.dart';
import 'rides_selection_tile.dart';

class RidesSelectionContent extends StatelessWidget {
  final RidesSelectionViewModel viewModel;
  const RidesSelectionContent({super.key, required this.viewModel});

  void onBackTap(BuildContext context) {
    Navigator.pop(context);
  }

  void onFilterPressed() {}
  void onRideSelected(Ride ride) {}
  void onPreferencePressed(BuildContext context) async {
    RidePreference? newPreference = await Navigator.of(context)
        .push<RidePreference>(
          AnimationUtils.createRightToLeftRoute(
            RidePreferenceModal(initialPreference: viewModel.currentPreference),
          ),
        );

    if (newPreference != null) {
      await viewModel.selectPreference(newPreference);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (viewModel.currentPreference == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            // 1 - Header
            RideSelectionHeader(
              ridePreference: viewModel.currentPreference!,
              onBackPressed: () => onBackTap(context),
              onFilterPressed: onFilterPressed,
              onPreferencePressed: () => onPreferencePressed(context),
            ),

            SizedBox(height: 100),

            // 2 - Rides list
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.matchingRides.length,
                itemBuilder: (ctx, index) => RideSelectionTile(
                  ride: viewModel.matchingRides[index],
                  onPressed: () =>
                      onRideSelected(viewModel.matchingRides[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
