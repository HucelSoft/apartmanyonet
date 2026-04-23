import 'package:flutter/material.dart';
import 'package:apartmanyonet/shared/widgets/placeholder_page.dart';

class AdminTransactionsPage extends StatelessWidget {
  const AdminTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) => const PlaceholderPage(
        title: 'Transactions',
        icon: Icons.account_balance_wallet_rounded,
        subtitle: 'View and record financial transactions across all flats.',
      );
}
