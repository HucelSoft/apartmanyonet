import 'package:flutter/material.dart';

import 'package:apartmanyonet/shared/widgets/placeholder_page.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) => const PlaceholderPage(
        title: 'Admin Dashboard',
        icon: Icons.dashboard_rounded,
        subtitle: 'Overview stats, site summaries and quick actions.',
      );
}
