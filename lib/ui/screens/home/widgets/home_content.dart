import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../../utils/animations_util.dart';
import '../../../../ui/widgets/pickers/ride_preference/bla_ride_preference_picker.dart';
import '../../rides_selection/rides_selection_screen.dart';
import '../view_model/home_model.dart';
import 'home_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

class HomeContent extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomeContent({super.key, required this.viewModel});

  void onRidePrefSelected(
    BuildContext context,
    RidePreference selectedPreference,
  ) async {
    await viewModel.selectPreference(selectedPreference);
    await Navigator.of(
      context,
    ).push(AnimationUtils.createBottomToTopRoute(RidesSelectionScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_buildBackground(), _buildForeground(context)]);
  }

  Widget _buildForeground(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Align(
          alignment: AlignmentGeometry.center,
          child: Text(
            "Your pick ride",
            style: BlaTextStyles.heading.copyWith(color: Colors.white),
          ),
        ),
        SizedBox(height: 100),
        Container(
          margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlaRidePreferencePicker(
                initRidePreference: viewModel.currentPreference,
                onRidePreferenceSelected: (pref) =>
                    onRidePrefSelected(context, pref),
              ),
              SizedBox(height: BlaSpacings.m),
              _buildHistory(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistory(BuildContext context) {
    final reversedHistory = viewModel.history.reversed.toList();
    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: reversedHistory.length,
        itemBuilder: (ctx, index) => HomeHistoryTile(
          ridePref: reversedHistory[index],
          onPressed: () => onRidePrefSelected(context, reversedHistory[index]),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(blablaHomeImagePath, fit: BoxFit.cover),
    );
  }
}
