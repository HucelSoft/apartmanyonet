import 'package:flutter/material.dart';
import 'package:apartmanyonet/shared/widgets/placeholder_page.dart';

class AdminTicketsPage extends StatelessWidget {
  const AdminTicketsPage({super.key});

  @override
  Widget build(BuildContext context) => const PlaceholderPage(
        title: 'Tickets',
        icon: Icons.confirmation_number_rounded,
        subtitle: 'Review and resolve maintenance tickets from residents.',
      );
}
