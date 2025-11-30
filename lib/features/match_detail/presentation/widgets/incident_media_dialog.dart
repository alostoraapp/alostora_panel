import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/l10n/s.dart';
import '../../domain/entities/incident_entity.dart';
import '../../domain/entities/incident_enums.dart';
import '../../../../core/config/constants.dart';

class IncidentMediaDialog extends StatefulWidget {
  final IncidentEntity incident;
  final Function(String? mediaUrl, XFile? mediaCover, int? videoTime) onSave;
  final VoidCallback onDelete;
  final Function(String status, String priority) onApprove;

  const IncidentMediaDialog({
    super.key,
    required this.incident,
    required this.onSave,
    required this.onDelete,
    required this.onApprove,
  });

  @override
  State<IncidentMediaDialog> createState() => _IncidentMediaDialogState();
}

class _IncidentMediaDialogState extends State<IncidentMediaDialog> {
  late TextEditingController _mediaUrlController;
  late TextEditingController _mediaCoverController;
  late TextEditingController _hoursController;
  late TextEditingController _minutesController;
  late TextEditingController _secondsController;
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedFile;
  bool _sendNotification = false;

  @override
  void initState() {
    super.initState();
    _mediaUrlController = TextEditingController(text: widget.incident.mediaUrl);
    _mediaCoverController =
        TextEditingController(text: widget.incident.mediaCover);

    final totalSeconds = widget.incident.videoTime ?? 0;
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    _hoursController = TextEditingController(text: hours.toString());
    _minutesController = TextEditingController(text: minutes.toString());
    _secondsController = TextEditingController(text: seconds.toString());
  }

  @override
  void dispose() {
    _mediaUrlController.dispose();
    _mediaCoverController.dispose();
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _pickedFile = image;
          _mediaCoverController.text = image.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(S.of(context).errorPickingImage(e.toString()))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final mediaStatus = widget.incident.mediaStatus;
    final isPendingApproval =
        mediaStatus == MatchIncidentMediaStatusChoices.pendingApproval;
    final hasMediaUrl = widget.incident.mediaUrl != null &&
        widget.incident.mediaUrl!.isNotEmpty;

    // Visibility Logic:
    // 1. If mediaUrl is empty/null -> Show ONLY mediaUrl field.
    // 2. If mediaStatus is pendingApproval -> Show ALL fields.
    // 3. Otherwise (e.g. draft with URL) -> Show ALL fields (assuming edit mode).
    // The user requirement "If media url is empty... only show media url" is strict.
    // "After status becomes pending_approve... show all fields".
    final showAllFields = hasMediaUrl || isPendingApproval;

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final dialogWidth = isMobile ? screenWidth : 400.0;
    final fontSize = isMobile ? 13.0 : null;

    final textStyle = TextStyle(fontSize: fontSize);
    final inputDecoration = InputDecoration(
      isDense: true,
      labelStyle: textStyle,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    );

    return AlertDialog(
      title: Text(s.editIncidentMedia,
          style: TextStyle(fontSize: isMobile ? 16 : 20)),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      content: SizedBox(
        width: dialogWidth,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _mediaUrlController,
                style: textStyle,
                decoration: inputDecoration.copyWith(labelText: s.mediaUrl),
              ),
              if (showAllFields) ...[
                const SizedBox(height: 12),
                TextFormField(
                  controller: _mediaCoverController,
                  style: textStyle,
                  decoration: inputDecoration.copyWith(
                    labelText: s.mediaCover,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.image, size: 20),
                      onPressed: _pickImage,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ),
                if (_mediaCoverController.text.isNotEmpty ||
                    _pickedFile != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _buildImagePreview(),
                  ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _hoursController,
                        style: textStyle,
                        decoration:
                            inputDecoration.copyWith(labelText: s.hours),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _minutesController,
                        style: textStyle,
                        decoration:
                            inputDecoration.copyWith(labelText: s.minutes),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _secondsController,
                        style: textStyle,
                        decoration:
                            inputDecoration.copyWith(labelText: s.seconds),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ],
                ),
                if (isPendingApproval) ...[
                  const SizedBox(height: 12),
                  const Divider(),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(s.sendNotification, style: textStyle),
                    subtitle: Text(s.sendNotificationSubtitle,
                        style:
                            textStyle.copyWith(fontSize: isMobile ? 11 : null)),
                    value: _sendNotification,
                    onChanged: (value) {
                      setState(() {
                        _sendNotification = value;
                      });
                    },
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actions: [
        Wrap(
          spacing: 8,
          alignment: WrapAlignment.end,
          children: [
            if (isPendingApproval)
              ElevatedButton(
                onPressed: () {
                  widget.onApprove(
                    MatchIncidentMediaStatusChoices.published.value,
                    _sendNotification
                        ? MatchIncidentMediaPriorityChoices.urgent.value
                        : MatchIncidentMediaPriorityChoices.normal.value,
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(s.incidentApproved)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  textStyle: textStyle,
                  minimumSize: const Size(0, 36),
                ),
                child: Text(s.approve),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                textStyle: textStyle,
                minimumSize: const Size(0, 36),
              ),
              child: Text(s.cancel),
            ),
            if (hasMediaUrl)
              TextButton(
                onPressed: () {
                  widget.onDelete();
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  textStyle: textStyle,
                  minimumSize: const Size(0, 36),
                ),
                child: Text(s.delete),
              ),
            if (!hasMediaUrl || _pickedFile != null)
              ElevatedButton(
                onPressed: () {
                  try {
                    final hours = int.tryParse(_hoursController.text) ?? 0;
                    final minutes = int.tryParse(_minutesController.text) ?? 0;
                    final seconds = int.tryParse(_secondsController.text) ?? 0;
                    final totalSeconds =
                        (hours * 3600) + (minutes * 60) + seconds;

                    widget.onSave(
                      _mediaUrlController.text.isEmpty
                          ? null
                          : _mediaUrlController.text,
                      _pickedFile,
                      totalSeconds > 0 ? totalSeconds : null,
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(s.requestSent)),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(s.error(e.toString()))),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  textStyle: textStyle,
                  minimumSize: const Size(0, 36),
                ),
                child: Text(s.save),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    if (_pickedFile != null) {
      return FutureBuilder<Uint8List>(
        future: _pickedFile!.readAsBytes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Image.memory(
              snapshot.data!,
              height: 100,
              fit: BoxFit.cover,
            );
          }
          return const SizedBox(
              height: 100, child: Center(child: CircularProgressIndicator()));
        },
      );
    } else if (_mediaCoverController.text.isNotEmpty) {
      String imageUrl = _mediaCoverController.text;
      if (!imageUrl.startsWith('http')) {
        imageUrl = '${AppConstants.baseUrl}$imageUrl';
      }
      return Image.network(
        imageUrl,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image),
      );
    }
    return const SizedBox.shrink();
  }
}
