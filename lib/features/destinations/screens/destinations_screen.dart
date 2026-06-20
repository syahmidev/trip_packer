import 'package:flutter/material.dart';

import '../../../core/widgets/module_placeholder.dart';

class DestinationsScreen extends StatelessWidget {
  const DestinationsScreen({required this.tripId, super.key});

  final int tripId;

  @override
  Widget build(BuildContext context) {
    return const ModulePlaceholder(
      title: 'Destinations',
      icon: Icons.public,
      phase: 'Phase 4',
    );
  }
}
