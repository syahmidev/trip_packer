import 'package:flutter/material.dart';

import '../../../core/widgets/module_placeholder.dart';

class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({required this.tripId, super.key});

  final int tripId;

  @override
  Widget build(BuildContext context) {
    return const ModulePlaceholder(
      title: 'Itinerary',
      icon: Icons.event_note_outlined,
      phase: 'Phase 5',
    );
  }
}
