// lib/src/screens/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; // For language changes
import '../utils/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true; // Example toggle
  Locale selectedLocale = const Locale('en'); // Default

  @override
  void initState() {
    super.initState();
    // Load initial user preferences, e.g. from SharedPreferences
    selectedLocale = context.locale;
  }

  void _onLocaleChange(Locale locale) {
    setState(() {
      selectedLocale = locale;
    });
    context.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('settings.title')), // e.g. "Settings" / "Ajustes"
      ),
      body: ListView(
        children: [
          // Language selection
          ListTile(
            title: Text(tr('settings.language')),
            trailing: DropdownButton<Locale>(
              value: selectedLocale,
              items: const [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: Locale('es'),
                  child: Text('Español'),
                ),
              ],
              onChanged: (locale) => _onLocaleChange(locale!),
            ),
          ),
          // Notifications toggle
          SwitchListTile(
            title: Text(tr('settings.notifications')),
            value: notificationsEnabled,
            onChanged: (val) {
              setState(() => notificationsEnabled = val);
              // Save to user preferences
            },
          ),
          // Dark / Light theme toggle or theme selection
          // ...
        ],
      ),
    );
  }
}
