import 'package:flutter/material.dart';

import '../../../core/widgets/module_placeholder.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({required this.tripId, super.key});

  final int tripId;

  @override
  Widget build(BuildContext context) {
    return const ModulePlaceholder(
      title: 'Transport',
      icon: Icons.directions_bus_outlined,
      phase: 'Phase 7',
    );
  }
}
