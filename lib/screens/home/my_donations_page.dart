import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/firestore_service.dart';
import '../../models/donation.dart';
import '../../widgets/donation_card.dart';

class MyDonationsPage extends StatelessWidget {
  const MyDonationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(title: const Text('My Donations')),
      body: StreamBuilder<List<Donation>>(
        stream: FirestoreService().getMyDonations(uid),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final items = snap.data!;
          if (items.isEmpty) return const Center(child: Text('No donations yet.'));
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) => DonationCard(donation: items[i]),
          );
        },
      ),
    );
  }
}
