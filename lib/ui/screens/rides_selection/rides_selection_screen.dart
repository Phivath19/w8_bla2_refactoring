import 'package:blabla/ui/state/ride_preferences_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/ride/ride_repository.dart';
import '../../../ui/states/ride_preferences_state.dart';
import 'view_model/rides_selection_model.dart';
import 'widgets/rides_selection_content.dart';

class RidesSelectionScreen extends StatefulWidget {
  const RidesSelectionScreen({super.key});

  @override
  State<RidesSelectionScreen> createState() => _RidesSelectionScreenState();
}

class _RidesSelectionScreenState extends State<RidesSelectionScreen> {
  late RidesSelectionViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = RidesSelectionViewModel(
      ridePreferenceState: context.read<RidePreferencesState>(),
      rideRepository: context.read<RideRepository>(),
    );
    _viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.dispose();
    super.dispose();
  }

  void _onViewModelChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RidesSelectionContent(viewModel: _viewModel);
  }
}
