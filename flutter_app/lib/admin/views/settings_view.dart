
import 'package:flutter/material.dart';
import '../admin_settings.dart';
import '../ui_helpers.dart';

class SettingsView extends StatelessWidget {
  final AdminSettings settings;

  const SettingsView({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settings,
      builder: (context, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Settings', style: headingStyle()),
              const SizedBox(height: 16),

              sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Appearance', style: headingStyle()),
                    const SizedBox(height: 10),
                    SwitchListTile(
                      value: settings.darkMode,
                      onChanged: settings.setDarkMode,
                      activeColor: Colors.orange.shade400,
                      title: const Text('Dark mode', style: TextStyle(color: Colors.white)),
                      subtitle: Text('Toggle dashboard theme', style: TextStyle(color: Colors.grey.shade400)),
                    ),
                    SwitchListTile(
                      value: settings.compactTables,
                      onChanged: settings.setCompactTables,
                      activeColor: Colors.orange.shade400,
                      title: const Text('Compact tables', style: TextStyle(color: Colors.white)),
                      subtitle: Text('Reduce spacing in tables', style: TextStyle(color: Colors.grey.shade400)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Notifications', style: headingStyle()),
                    const SizedBox(height: 10),
                    SwitchListTile(
                      value: settings.emailNotifications,
                      onChanged: settings.setEmailNotifications,
                      activeColor: Colors.orange.shade400,
                      title: const Text('Email notifications', style: TextStyle(color: Colors.white)),
                      subtitle: Text('Send admin alerts to email', style: TextStyle(color: Colors.grey.shade400)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Moderation', style: headingStyle()),
                    const SizedBox(height: 10),
                    SwitchListTile(
                      value: settings.autoApproveArtists,
                      onChanged: settings.setAutoApproveArtists,
                      activeColor: Colors.orange.shade400,
                      title: const Text('Auto-approve artist submissions', style: TextStyle(color: Colors.white)),
                      subtitle: Text('If off, submissions stay pending', style: TextStyle(color: Colors.grey.shade400)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'These settings are stored in-memory in this demo. You can persist them using shared_preferences later.',
                      style: bodyStyle().copyWith(color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
