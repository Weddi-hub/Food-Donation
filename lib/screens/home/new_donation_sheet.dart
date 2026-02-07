import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/donation.dart';
import '../../services/firestore_service.dart';

class NewDonationSheet extends StatefulWidget {
  const NewDonationSheet({super.key});

  @override
  State<NewDonationSheet> createState() => _NewDonationSheetState();
}

class _NewDonationSheetState extends State<NewDonationSheet> {
  final _formKey = GlobalKey<FormState>();
  DonationType _type = DonationType.food;
  final _title = TextEditingController();
  final _desc = TextEditingController();
  final _amount = TextEditingController();
  final _donorName = TextEditingController();
  final _contact = TextEditingController();
  final _address = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _donorName.text = user?.displayName ?? '';
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    _amount.dispose();
    _donorName.dispose();
    _contact.dispose();
    _address.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final donation = Donation(
        id: 'temp',
        title: _title.text.trim(),
        description: _desc.text.trim(),
        type: _type,
        amount: double.tryParse(_amount.text.trim()) ?? 1,
        donorName: _donorName.text.trim(),
        contact: _contact.text.trim(),
        pickupAddress: _address.text.trim(),
        userId: FirebaseAuth.instance.currentUser!.uid,
        createdAt: DateTime.now(),
        status: 'open',
      );
      await FirestoreService().addDonation(donation);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, bottom + 16),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Create Donation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              SegmentedButton<DonationType>(
                segments: const [
                  ButtonSegment(value: DonationType.food, label: Text('Food'), icon: Icon(Icons.restaurant)),
                  ButtonSegment(value: DonationType.other, label: Text('Other'), icon: Icon(Icons.volunteer_activism)),
                ],
                selected: {_type},
                onSelectionChanged: (s) => setState(() => _type = s.first),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Title (e.g., 10 Meals)'),
                validator: (v) => v != null && v.isNotEmpty ? null : 'Required',
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _desc,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _amount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantity / Amount'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _donorName,
                decoration: const InputDecoration(labelText: 'Donor Name'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _contact,
                decoration: const InputDecoration(labelText: 'Contact (phone/email)'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _address,
                decoration: const InputDecoration(labelText: 'Pickup Address'),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _saving ? null : _submit,
                icon: _saving ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.check),
                label: const Text('Submit Donation'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
