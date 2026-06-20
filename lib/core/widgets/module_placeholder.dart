import 'package:flutter/material.dart';

import 'empty_state.dart';

/// Thin scaffold used by modules that are wired into navigation but whose
/// full CRUD is scheduled for a later phase of the roadmap.
class ModulePlaceholder extends StatelessWidget {
  const ModulePlaceholder({
    required this.title,
    required this.icon,
    required this.phase,
    super.key,
  });

  final String title;
  final IconData icon;
  final String phase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: EmptyState(
        icon: icon,
        title: '$title coming up',
        message:
            'This module is scaffolded and wired into navigation. '
            'CRUD lands in $phase of the roadmap.',
      ),
    );
  }
}
