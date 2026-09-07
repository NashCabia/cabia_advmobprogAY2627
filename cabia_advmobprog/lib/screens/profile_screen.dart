import 'package:flutter/material.dart';
import 'package:cabia_mobile/models/user.dart';
import 'package:cabia_mobile/services/user_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await UserService.logout();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/signin', (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('My Profile')),
    body: FutureBuilder<User?>(
      future: UserService.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final user = snapshot.data;
        if (user == null) return const Center(child: Text('No signed-in user'));
        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            CircleAvatar(
              radius: 54,
              backgroundImage: user.image.isEmpty
                  ? null
                  : NetworkImage(user.image),
              child: user.image.isEmpty
                  ? const Icon(Icons.person, size: 52)
                  : null,
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                '${user.firstName} ${user.lastName}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 24),
            _ProfileRow(label: 'Username', value: user.username),
            _ProfileRow(label: 'Email', value: user.email),
            _ProfileRow(label: 'User ID', value: '${user.id}'),
            _ProfileRow(label: 'Gender', value: user.gender),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout),
              label: const Text('Log Out'),
            ),
          ],
        );
      },
    ),
  );
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(label),
    subtitle: Text(value),
    contentPadding: EdgeInsets.zero,
  );
}
