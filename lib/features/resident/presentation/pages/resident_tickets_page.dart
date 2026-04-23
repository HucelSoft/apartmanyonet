import 'package:flutter/material.dart';
import 'package:apartmanyonet/shared/widgets/placeholder_page.dart';

class ResidentTicketsPage extends StatelessWidget {
  const ResidentTicketsPage({super.key});

  @override
  Widget build(BuildContext context) => const PlaceholderPage(
        title: 'Support Tickets',
        icon: Icons.build_circle_rounded,
        subtitle: 'Submit maintenance requests and track their status.',
      );
}
