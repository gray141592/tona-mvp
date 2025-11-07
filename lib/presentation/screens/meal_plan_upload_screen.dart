import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tona_mvp/presentation/widgets/waiting_screen_shell.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class MealPlanUploadScreen extends StatefulWidget {
  final VoidCallback onFileSelected;

  const MealPlanUploadScreen({
    super.key,
    required this.onFileSelected,
  });

  @override
  State<MealPlanUploadScreen> createState() => _MealPlanUploadScreenState();
}

class _MealPlanUploadScreenState extends State<MealPlanUploadScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String? _selectedFileName;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    debugPrint('_pickFile called');

    setState(() {
      _isUploading = true;
    });

    try {
      debugPrint('Opening file picker...');
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      debugPrint('File picker result: $result');

      if (result != null && result.files.single.path != null) {
        debugPrint('File selected: ${result.files.single.name}');
        setState(() {
          _selectedFileName = result.files.single.name;
        });
      } else {
        debugPrint('No file selected or path is null');
        setState(() {
          _selectedFileName = 'mock_meal_plan.pdf';
        });
      }
    } catch (e) {
      debugPrint('File picker error: $e');
      setState(() {
        _selectedFileName = 'mock_meal_plan.pdf';
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _continue() {
    debugPrint('Continue button clicked');
    debugPrint('Calling onFileSelected callback...');
    widget.onFileSelected();
    debugPrint('onFileSelected callback completed');
  }

  @override
  Widget build(BuildContext context) {
    return WaitingScreenShell(
      title: 'Upload Your Meal Plan',
      subtitle: Text(
        'Select your meal plan file to get started',
        style: AppTypography.bodyLarge.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _pickFile,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.xxl),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _selectedFileName != null
                    ? AppColors.buttonSuccess
                    : AppColors.divider,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.buttonPrimary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _selectedFileName != null
                        ? Icons.check_circle
                        : Icons.upload_file,
                    size: 64,
                    color: _selectedFileName != null
                        ? AppColors.buttonSuccess
                        : AppColors.buttonPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (_selectedFileName != null) ...[
                  Text(
                    'File Selected',
                    style: AppTypography.titleLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _selectedFileName!,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ] else ...[
                  Text(
                    'Tap to select file',
                    style: AppTypography.titleLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'PDF, DOC, or any file format',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      footer: ElevatedButton(
        onPressed: _selectedFileName != null ? _continue : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.md,
          ),
        ),
        child: _isUploading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : const Text('Continue'),
      ),
    );
  }
}
