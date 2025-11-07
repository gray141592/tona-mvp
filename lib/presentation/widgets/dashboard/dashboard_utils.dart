String relativeTimeLabel(Duration difference) {
  final isFuture = !difference.isNegative;
  final absolute = difference.abs();

  if (absolute.inMinutes == 0) {
    return isFuture ? 'in under a minute' : 'less than a minute ago';
  }

  if (absolute.inMinutes < 60) {
    final minutes = absolute.inMinutes;
    return isFuture ? 'in $minutes min' : '$minutes min ago';
  }

  final hours = absolute.inHours;
  final minutes = absolute.inMinutes % 60;

  if (minutes == 0) {
    return isFuture ? 'in $hours h' : '$hours h ago';
  }

  return isFuture ? 'in ${hours}h ${minutes}m' : '${hours}h ${minutes}m ago';
}
