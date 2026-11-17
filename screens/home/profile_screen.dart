import 'package:flutter/material.dart';
import '../../services/csv_service.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isProcessing = false;

  Future<void> _handleExport() async {
    setState(() => _isProcessing = true);
    final success = await CsvService.exportEventsToCSV();
    setState(() => _isProcessing = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Events exported successfully!' : 'No events to export.'),
          backgroundColor: success ? Colors.green : Colors.orange,
        ),
      );
    }
  }

  Future<void> _handleImport() async {
    setState(() => _isProcessing = true);
    final success = await CsvService.importEventsFromCSV();
    setState(() => _isProcessing = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Events imported successfully!' : 'Import canceled or failed.'),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Profile')),
      body: _isProcessing
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
              child: Icon(Icons.person, size: 50, color: theme.colorScheme.primary),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'User Name',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              'user@example.com',
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 40),
          const Text('DATA MANAGEMENT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.upload_file, color: Colors.blue),
                  title: const Text('Import Events from CSV'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: _handleImport,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.download, color: Colors.green),
                  title: const Text('Export Events to CSV'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: _handleExport,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('ACCOUNT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text('Settings'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.dark_mode_outlined),
                  title: Text('Dark Mode'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text('Help & Support'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Logout', style: TextStyle(color: Colors.red)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}