import 'package:flutter/material.dart';

import '../../../core/widgets/module_placeholder.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModulePlaceholder(
      title: 'Settings',
      icon: Icons.settings_outlined,
      phase: 'Phase 11 (theme, default currency)',
    );
  }
}
