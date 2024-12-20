import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Enum for user types
enum UserType { doctor, student, guest }

// State class for getting started
class GettingStartedState {
  final UserType? selectedUserType;
  final bool showDetailsForm;

  GettingStartedState({
    this.selectedUserType,
    this.showDetailsForm = false,
  });

  GettingStartedState copyWith({
    UserType? selectedUserType,
    bool? showDetailsForm,
  }) {
    return GettingStartedState(
      selectedUserType: selectedUserType ?? this.selectedUserType,
      showDetailsForm: showDetailsForm ?? this.showDetailsForm,
    );
  }
}

// Riverpod provider for getting started state
final gettingStartedStateProvider = 
  StateNotifierProvider<GettingStartedNotifier, GettingStartedState>((ref) {
    return GettingStartedNotifier();
});

// State notifier for managing getting started state
class GettingStartedNotifier extends StateNotifier<GettingStartedState> {
  GettingStartedNotifier() : super(GettingStartedState());

  // Select user type
  void selectUserType(UserType userType) {
    state = state.copyWith(
      selectedUserType: userType,
      showDetailsForm: true,
    );
  }

  // Deselect user type
  void deselectUserType() {
    state = GettingStartedState();
  }

  // Validate form before proceeding
  bool validateForm(BuildContext context) {
    // Implement form validation logic
    if (state.selectedUserType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a user type')),
      );
      return false;
    }
    return true;
  }
}
