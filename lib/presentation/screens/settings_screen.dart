
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tona_mvp/core/utils/time_provider.dart';
import 'package:tona_mvp/l10n/app_localizations.dart';
import 'package:tona_mvp/main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localizations.language, style: Theme.of(context).textTheme.headline6),
            ListTile(
              title: Text(localizations.english),
              onTap: () => _changeLanguage('en'),
            ),
            ListTile(
              title: Text(localizations.german),
              onTap: () => _changeLanguage('de'),
            ),
            ListTile(
              title: Text(localizations.serbian),
              onTap: () => _changeLanguage('sr'),
            ),
            const Divider(),
            ListTile(
              title: Text(localizations.resetOnboarding),
              onTap: () {
                _prefs.setBool('onboardingComplete', false);
                Navigator.of(context).pushNamedAndRemoveUntil('/splash', (route) => false);
              },
            ),
            const Divider(),
            ListTile(
              title: Text(localizations.resetSwipeCoach),
              onTap: () {
                _prefs.setBool('swipeCoachDone', false);
              },
            ),
            const Divider(),
            ListTile(
              title: Text(localizations.changeTime),
              onTap: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedTime != null) {
                  //TODO: Implement time change logic
                  TimeProvider.setOverride(selectedTime);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _changeLanguage(String languageCode) {
    MyApp.setLocale(context, Locale(languageCode));
  }
}
