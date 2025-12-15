import 'package:flutter/material.dart';
import 'package:tona_mvp/l10n/app_localizations.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../widgets/dashboard/dashboard_glycemic_info_content.dart';
import '../widgets/waiting_screen_shell.dart';

class DashboardGlycemicInfoScreen extends StatelessWidget {
  const DashboardGlycemicInfoScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const DashboardGlycemicInfoScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return WaitingScreenShell(
      title: localizations.glycemicIndexQuickGuide,
      subtitle: Text(
        localizations.glycemicIndexQuickGuideBody,
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      body: const DashboardGlycemicInfoContent(),
      footer: FilledButton.icon(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.check_circle_outline),
        label: Text(localizations.gotIt),
      ),
    );
  }
}
