import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/destination_providers.dart';

/// Renders a trip's ordered route as "Istanbul → Sofia → Skopje" (plan §8, §15).
///
/// Reads the live `destinations` stream so it stays in sync as the route is
/// edited. Renders nothing when the trip has no destinations yet.
class DestinationRouteText extends ConsumerWidget {
  const DestinationRouteText({required this.tripId, this.maxLines = 1, super.key});

  final int tripId;
  final int maxLines;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final destinations = ref.watch(destinationsProvider(tripId));

    return destinations.maybeWhen(
      data: (list) {
        if (list.isEmpty) return const SizedBox.shrink();
        final route = list.map((d) => d.city).join(' → ');
        return Text(
          route,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryText,
              ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}
