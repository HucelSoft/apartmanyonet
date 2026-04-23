import 'package:flutter/material.dart';
import 'package:apartmanyonet/shared/widgets/placeholder_page.dart';

class AdminAnnouncementsPage extends StatelessWidget {
  const AdminAnnouncementsPage({super.key});

  @override
  Widget build(BuildContext context) => const PlaceholderPage(
        title: 'Announcements',
        icon: Icons.campaign_rounded,
        subtitle: 'Post and manage site-wide announcements for residents.',
      );
}
