import 'package:flutter/material.dart';
import 'package:apartmanyonet/shared/widgets/placeholder_page.dart';

class AdminBuildingsPage extends StatelessWidget {
  const AdminBuildingsPage({super.key});

  @override
  Widget build(BuildContext context) => const PlaceholderPage(
        title: 'Buildings',
        icon: Icons.apartment_rounded,
        subtitle: 'Manage sites, apartment blocks and flat units.',
      );
}
