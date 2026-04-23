import 'package:flutter/material.dart';
import 'package:apartmanyonet/shared/widgets/placeholder_page.dart';

class ResidentMetersPage extends StatelessWidget {
  const ResidentMetersPage({super.key});

  @override
  Widget build(BuildContext context) => const PlaceholderPage(
        title: 'Meter Readings',
        icon: Icons.speed_rounded,
        subtitle: 'View water, gas and electricity meter readings for your flat.',
      );
}
