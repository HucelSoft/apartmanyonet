import 'package:flutter/material.dart';
import 'package:apartmanyonet/shared/widgets/placeholder_page.dart';

class ResidentPaymentsPage extends StatelessWidget {
  const ResidentPaymentsPage({super.key});

  @override
  Widget build(BuildContext context) => const PlaceholderPage(
        title: 'Payments',
        icon: Icons.payments_rounded,
        subtitle: 'View your balance, pay monthly dues and transaction history.',
      );
}
