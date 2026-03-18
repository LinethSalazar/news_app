import 'package:fake_assigment_1/cubit/new_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NewsCubit>();

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          SettingsTile(
            icon: Icons.newspaper,
            title: 'Clear news cache',
            subtitle: 'Removes locally cached news articles',
            onTap: () => showConfirmDialog(
              context,
              title: 'Clear news cache',
              message:
                  'This will remove cached articles. They will be re-fetched next time.',
              onConfirm: () => {
                cubit.clearNewsCache(),
                cubit.refreshNews(),
              }
            ),
          ),
          SettingsTile(
            icon: Icons.bookmark_remove,
            title: 'Clear saved articles',
            subtitle: 'Removes all your saved articles',
            onTap: () => showConfirmDialog(
              context,
              title: 'Clear saved articles',
              message: 'All your saved articles will be permanently deleted.',
              onConfirm: () => cubit.clearSavedArticles(),
            ),
          ),
          SettingsTile(
            icon: Icons.remove_red_eye_outlined,
            title: 'Clear read history',
            subtitle: 'Marks all articles as unread',
            onTap: () => showConfirmDialog(
              context,
              title: 'Clear read history',
              message: 'All articles will be marked as unread.',
              onConfirm: () => cubit.clearReadHistory(),
            ),
          ),
          SettingsTile(
            icon: Icons.image_not_supported_outlined,
            title: 'Clear image cache',
            subtitle: 'Frees up disk space used by cached images',
            onTap: () => showConfirmDialog(
              context,
              title: 'Clear image cache',
              message:
                  'Cached images will be deleted. They will re-download when needed.',
              onConfirm: () => cubit.clearImageCache(),
            ),
          ),
        ],
      ),
    );
  }
}
void showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('$title done!')));
          },
          child: Text('Confirm', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.redAccent),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
