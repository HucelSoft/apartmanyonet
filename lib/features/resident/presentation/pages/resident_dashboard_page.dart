import 'package:flutter/material.dart';
import 'package:apartmanyonet/shared/widgets/placeholder_page.dart';

class ResidentDashboardPage extends StatelessWidget {
  const ResidentDashboardPage({super.key});

  @override
  Widget build(BuildContext context) => const PlaceholderPage(
        title: 'My Dashboard',
        icon: Icons.space_dashboard_rounded,
        subtitle: 'Your flat overview, pending dues and recent activity.',
      );
}
