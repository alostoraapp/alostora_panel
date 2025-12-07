import 'package:flutter/material.dart';
import '../../l10n/s.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorView({
    super.key,
    required this.message,
    this.onRetry,
  });

  bool get _isConnectionError {
    final lowerMessage = message.toLowerCase();
    return lowerMessage.contains('connection') ||
        lowerMessage.contains('socket') ||
        lowerMessage.contains('network') ||
        lowerMessage.contains('dio') ||
        lowerMessage.contains('host lookup') ||
        lowerMessage.contains('handshake');
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final isConnectionError = _isConnectionError;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isConnectionError
                  ? Icons.wifi_off_rounded
                  : Icons.error_outline_rounded,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              isConnectionError ? s.noInternetConnection : s.somethingWentWrong,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              isConnectionError ? s.checkYourConnection : message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(s.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
