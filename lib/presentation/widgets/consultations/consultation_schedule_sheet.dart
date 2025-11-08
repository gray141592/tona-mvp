import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class ConsultationScheduleResult {
  const ConsultationScheduleResult({
    required this.scheduledAt,
    required this.nutritionistName,
    required this.meetingFormat,
    this.location,
    this.meetingLink,
    this.preparationNotes = const [],
  });

  final DateTime scheduledAt;
  final String nutritionistName;
  final String meetingFormat;
  final String? location;
  final String? meetingLink;
  final List<String> preparationNotes;
}

class ConsultationScheduleSheet extends StatefulWidget {
  const ConsultationScheduleSheet({
    super.key,
    this.initialNutritionistName,
    this.initialScheduledAt,
    this.initialMeetingFormat,
    this.initialLocation,
    this.initialMeetingLink,
    this.initialPreparationNotes,
  });

  final String? initialNutritionistName;
  final DateTime? initialScheduledAt;
  final String? initialMeetingFormat;
  final String? initialLocation;
  final String? initialMeetingLink;
  final List<String>? initialPreparationNotes;

  static Future<ConsultationScheduleResult?> show(
    BuildContext context, {
    String? initialNutritionistName,
    DateTime? initialScheduledAt,
    String? initialMeetingFormat,
    String? initialLocation,
    String? initialMeetingLink,
    List<String>? initialPreparationNotes,
  }) {
    return showModalBottomSheet<ConsultationScheduleResult>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ConsultationScheduleSheet(
          initialNutritionistName: initialNutritionistName,
          initialScheduledAt: initialScheduledAt,
          initialMeetingFormat: initialMeetingFormat,
          initialLocation: initialLocation,
          initialMeetingLink: initialMeetingLink,
          initialPreparationNotes: initialPreparationNotes,
        ),
      ),
    );
  }

  @override
  State<ConsultationScheduleSheet> createState() =>
      _ConsultationScheduleSheetState();
}

class _ConsultationScheduleSheetState extends State<ConsultationScheduleSheet> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  late final TextEditingController _nutritionistController;
  late final TextEditingController _locationController;
  late final TextEditingController _meetingLinkController;
  late final TextEditingController _preparationController;
  String _meetingFormat = 'Video call';

  @override
  void initState() {
    super.initState();
    _nutritionistController = TextEditingController(
      text: widget.initialNutritionistName ?? '',
    );
    _locationController =
        TextEditingController(text: widget.initialLocation ?? '');
    _meetingLinkController =
        TextEditingController(text: widget.initialMeetingLink ?? '');
    _preparationController = TextEditingController(
      text: widget.initialPreparationNotes?.join(', ') ?? '',
    );

    final initialDateTime = widget.initialScheduledAt;
    if (initialDateTime != null) {
      _selectedDate = DateTime(
        initialDateTime.year,
        initialDateTime.month,
        initialDateTime.day,
      );
      _selectedTime =
          TimeOfDay(hour: initialDateTime.hour, minute: initialDateTime.minute);
    }

    final allowedFormats = {'Video call', 'In-person', 'Phone'};
    if (widget.initialMeetingFormat != null &&
        allowedFormats.contains(widget.initialMeetingFormat)) {
      _meetingFormat = widget.initialMeetingFormat!;
    }
  }

  @override
  void dispose() {
    _nutritionistController.dispose();
    _locationController.dispose();
    _meetingLinkController.dispose();
    _preparationController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _selectedDate != null &&
      _selectedTime != null &&
      _nutritionistController.text.trim().isNotEmpty;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now.add(const Duration(days: 7)),
      firstDate: now.subtract(const Duration(days: 90)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? const TimeOfDay(hour: 10, minute: 0),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submit() {
    if (!_isValid || _selectedDate == null || _selectedTime == null) {
      return;
    }

    final scheduledAt = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    Navigator.of(context).pop(
      ConsultationScheduleResult(
        scheduledAt: scheduledAt,
        nutritionistName: _nutritionistController.text.trim(),
        meetingFormat: _meetingFormat,
        location: _locationController.text.trim().isEmpty
            ? null
            : _locationController.text.trim(),
        meetingLink: _meetingLinkController.text.trim().isEmpty
            ? null
            : _meetingLinkController.text.trim(),
        preparationNotes: _splitCommaList(_preparationController.text),
      ),
    );
  }

  List<String> _splitCommaList(String input) {
    return input
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Schedule consultation',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _nutritionistController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nutritionist name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_today_rounded),
                    label: Text(
                      _selectedDate == null
                          ? 'Select date'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickTime,
                    icon: const Icon(Icons.schedule_rounded),
                    label: Text(
                      _selectedTime == null
                          ? 'Select time'
                          : _selectedTime!.format(context),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String>(
              value: _meetingFormat,
              items: const [
                DropdownMenuItem(
                  value: 'Video call',
                  child: Text('Video call'),
                ),
                DropdownMenuItem(
                  value: 'In-person',
                  child: Text('In-person'),
                ),
                DropdownMenuItem(
                  value: 'Phone',
                  child: Text('Phone'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _meetingFormat = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Format',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            if (_meetingFormat == 'In-person') ...[
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            if (_meetingFormat == 'Video call') ...[
              TextField(
                controller: _meetingLinkController,
                decoration: const InputDecoration(
                  labelText: 'Meeting link',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            TextField(
              controller: _preparationController,
              decoration: const InputDecoration(
                labelText: 'Preparation notes (comma separated)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isValid ? _submit : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.md,
                  ),
                ),
                child: const Text('Save appointment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
