import 'package:flutter/material.dart';

import '../../../core/widgets/module_placeholder.dart';

class AccommodationScreen extends StatelessWidget {
  const AccommodationScreen({required this.tripId, super.key});

  final int tripId;

  @override
  Widget build(BuildContext context) {
    return const ModulePlaceholder(
      title: 'Accommodation',
      icon: Icons.hotel_outlined,
      phase: 'Phase 8',
    );
  }
}
