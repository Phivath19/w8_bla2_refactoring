import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../utils/animations_util.dart';
import '../../../ui/state/ride_preferences_state.dart';
import '../../theme/theme.dart';
import '../../widgets/pickers/ride_preference/bla_ride_preference_picker.dart';
import '../rides_selection/rides_selection_screen.dart';
import 'widgets/home_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  // Listen to global state
  @override
  void initState() {
    super.initState();
    context.read<RidePreferencesState>().addListener(_onStateChanged);
  }

  @override
  void dispose() {
    context.read<RidePreferencesState>().removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() {
    setState(() {}); 
  }

  void onRidePrefSelected(RidePreference selectedPreference) async {
    //  Update global state
    await context
        .read<RidePreferencesState>()
        .selectPreference(selectedPreference);

    //  Navigate to rides screen
    await Navigator.of(context).push(
      AnimationUtils.createBottomToTopRoute(RidesSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_buildBackground(), _buildForeground()]);
  }

  Widget _buildForeground() {
    // Read from global state
    final ridePrefsState = context.read<RidePreferencesState>();

    return Column(
      children: [
        SizedBox(height: 16),
        Align(
          alignment: AlignmentGeometry.center,
          child: Text(
            "Your pick of rides at low price",
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
              // 2 - THE FORM
              BlaRidePreferencePicker(
                initRidePreference: ridePrefsState.currentPreference,
                onRidePreferenceSelected: onRidePrefSelected,
              ),
              SizedBox(height: BlaSpacings.m),

              // 3 - THE HISTORY
              _buildHistory(ridePrefsState.history),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistory(List<RidePreference> history) {
    final reversedHistory = history.reversed.toList();
    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: reversedHistory.length,
        itemBuilder: (ctx, index) => HomeHistoryTile(
          ridePref: reversedHistory[index],
          onPressed: () => onRidePrefSelected(reversedHistory[index]),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
