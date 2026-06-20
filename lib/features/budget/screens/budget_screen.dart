import 'package:flutter/material.dart';

import '../../../core/widgets/module_placeholder.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({required this.tripId, super.key});

  final int tripId;

  @override
  Widget build(BuildContext context) {
    return const ModulePlaceholder(
      title: 'Budget',
      icon: Icons.account_balance_wallet_outlined,
      phase: 'Phase 6',
    );
  }
}
