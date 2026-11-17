import 'package:flutter/material.dart';
import '../../services/storage_service.dart';
import '../../models/event_model.dart';

class ContactDetailsScreen extends StatefulWidget {
  final String contactId;
  const ContactDetailsScreen({super.key, required this.contactId});

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  ContactModel? _contact;

  @override
  void initState() {
    super.initState();
    _loadContact();
  }

  void _loadContact() {
    setState(() {
      _contact = StorageService.getContact(widget.contactId);
    });
  }

  Future<void> _toggleFavorite() async {
    if (_contact == null) return;
    final updated = ContactModel(
      id: _contact!.id,
      name: _contact!.name,
      email: _contact!.email,
      phone: _contact!.phone,
      address: _contact!.address,
      company: _contact!.company,
      jobTitle: _contact!.jobTitle,
      isFavorite: !_contact!.isFavorite,
      createdAt: _contact!.createdAt,
      updatedAt: DateTime.now().toIso8601String(),
    );
    await StorageService.updateContact(updated);
    _loadContact();
  }

  Future<void> _deleteContact() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Contact'),
        content: const Text('Are you sure you want to delete this contact?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true && _contact != null) {
      await StorageService.deleteContact(_contact!.id);
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_contact == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Contact Details')),
        body: const Center(child: Text('Contact not found')),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Contact Details'),
        actions: [
          IconButton(
            icon: Icon(_contact!.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: _contact!.isFavorite ? Colors.red : null,
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: _deleteContact,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
              child: Text(
                _contact!.name[0].toUpperCase(),
                style: TextStyle(fontSize: 48, color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildInfoTile(Icons.person, 'Name', _contact!.name),
          _buildInfoTile(Icons.email, 'Email', _contact!.email),
          if (_contact!.phone != null) _buildInfoTile(Icons.phone, 'Phone', _contact!.phone!),
          if (_contact!.company != null) _buildInfoTile(Icons.business, 'Company', _contact!.company!),
          if (_contact!.jobTitle != null) _buildInfoTile(Icons.work, 'Job Title', _contact!.jobTitle!),
          if (_contact!.address != null) _buildInfoTile(Icons.location_on, 'Address', _contact!.address!),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(label, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withOpacity(0.6))),
        subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
    );
  }
}