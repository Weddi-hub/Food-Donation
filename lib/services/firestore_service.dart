import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/donation.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Stream<List<Donation>> getLiveDonations() {
    return _db
        .collection('donations')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => Donation.fromDoc(d)).toList());
  }

  Stream<List<Donation>> getMyDonations(String uid) {
    return _db
        .collection('donations')
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => Donation.fromDoc(d)).toList());
  }

  Future<void> addDonation(Donation donation) async {
    await _db.collection('donations').add(donation.toMap());
  }

  Future<void> updateStatus(String id, String status) async {
    await _db.collection('donations').doc(id).update({'status': status});
  }
}
