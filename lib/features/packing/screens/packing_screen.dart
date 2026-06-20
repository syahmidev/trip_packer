import 'package:flutter/material.dart';

import '../../../core/widgets/module_placeholder.dart';

class PackingScreen extends StatelessWidget {
  const PackingScreen({required this.tripId, super.key});

  final int tripId;

  @override
  Widget build(BuildContext context) {
    return const ModulePlaceholder(
      title: 'Packing',
      icon: Icons.checklist_outlined,
      phase: 'Phase 9',
    );
  }
}
