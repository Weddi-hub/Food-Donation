import 'package:cloud_firestore/cloud_firestore.dart';

enum DonationType { food, other }

class Donation {
  final String id;
  final String title;
  final String description;
  final DonationType type;
  final double amount; // quantity/amount value
  final String donorName;
  final String contact;
  final String pickupAddress;
  final String userId;
  final DateTime createdAt;
  final String status; // 'open', 'claimed', 'closed'

  Donation({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.amount,
    required this.donorName,
    required this.contact,
    required this.pickupAddress,
    required this.userId,
    required this.createdAt,
    required this.status,
  });

  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'type': type.name,
    'amount': amount,
    'donorName': donorName,
    'contact': contact,
    'pickupAddress': pickupAddress,
    'userId': userId,
    'createdAt': Timestamp.fromDate(createdAt),
    'status': status,
  };

  factory Donation.fromDoc(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return Donation(
      id: doc.id,
      title: d['title'] ?? '',
      description: d['description'] ?? '',
      type: (d['type'] == 'food') ? DonationType.food : DonationType.other,
      amount: (d['amount'] is int) ? (d['amount'] as int).toDouble() : (d['amount'] ?? 0.0).toDouble(),
      donorName: d['donorName'] ?? '',
      contact: d['contact'] ?? '',
      pickupAddress: d['pickupAddress'] ?? '',
      userId: d['userId'] ?? '',
      createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: d['status'] ?? 'open',
    );
  }
}
