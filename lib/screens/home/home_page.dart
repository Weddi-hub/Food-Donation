import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/firestore_service.dart';
import '../../widgets/donation_card.dart';
import '../../widgets/app_drawer.dart';
import '../../models/donation.dart';
import 'new_donation_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  List<Donation> get _demoDonations => [
    Donation(
      id: 'sample1',
      title: '10 Meals (Chicken Biryani)',
      description: '10 packed meals freshly prepared. Ready for pickup.',
      type: DonationType.food,
      amount: 10,
      donorName: 'Alia',
      contact: '+92 300 1234567',
      pickupAddress: 'Gulberg, Lahore',
      userId: 'sample',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      status: 'open',
    ),
    Donation(
      id: 'sample2',
      title: '15 Fruit Packs',
      description: 'Fruit packs: apples and bananas, ready to be collected.',
      type: DonationType.food,
      amount: 15,
      donorName: 'Sami',
      contact: '+92 301 7654321',
      pickupAddress: 'Model Town, Lahore',
      userId: 'sample',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      status: 'open',
    ),
    Donation(
      id: 'sample3',
      title: 'Leftover Restaurant Meals (20)',
      description: 'Assorted restaurant meals leftover from event. Please collect.',
      type: DonationType.food,
      amount: 20,
      donorName: 'BBQ House',
      contact: 'bbq@example.com',
      pickupAddress: 'Phase 5, Islamabad',
      userId: 'sample',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      status: 'open',
    ),
    Donation(
      id: 'sample4',
      title: 'Bread & Pastries (30)',
      description: 'Fresh bakery items near expiry — perfect for distribution.',
      type: DonationType.food,
      amount: 30,
      donorName: 'The Bakery',
      contact: 'bakery@example.com',
      pickupAddress: 'Awan Town, Peshawar',
      userId: 'sample',
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      status: 'open',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    const accent = Color(0xFF2A7B5F);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Donations'),
        backgroundColor: accent,
      ),
      drawer: const AppDrawer(),
      body: StreamBuilder<List<Donation>>(
        stream: FirestoreService().getLiveDonations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snapshot.data ?? <Donation>[];

          // if Firestore empty, show demo donations (so UI looks populated)
          final showDemo = items.isEmpty;
          final source = showDemo ? _demoDonations : items;

          return RefreshIndicator(
            onRefresh: () async {
              // optional: simply wait for realtime stream to update
              await Future.delayed(const Duration(milliseconds: 400));
            },
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemCount: source.length + (showDemo ? 1 : 0),
              itemBuilder: (context, index) {
                // When showing demo, display a small banner at top
                if (showDemo && index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: Card(
                      color: Colors.orange.shade50,
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: const [
                            Icon(Icons.info_outline, color: Colors.orange),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Showing sample donations for demo. Your live donations will appear here once added.',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                final donation = source[showDemo ? index - 1 : index];
                return DonationCard(
                  donation: donation,
                  onClaim: donation.status == 'open'
                      ? () {
                    // If demo, don't update Firestore; if real, update status
                    if (donation.userId == 'sample') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This is a demo donation.')));
                    } else {
                      FirestoreService().updateStatus(donation.id, 'claimed');
                    }
                  }
                      : null,
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            builder: (_) => const NewDonationSheet(),
          );
        },
        label: const Text('Become a Donor'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
