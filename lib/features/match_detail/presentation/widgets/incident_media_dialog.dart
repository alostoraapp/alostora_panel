import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/l10n/s.dart';
import '../../domain/entities/incident_entity.dart';

class IncidentMediaDialog extends StatefulWidget {
  final IncidentEntity incident;
  final Function(String? mediaUrl, XFile? mediaCover, int? videoTime) onSave;
  final VoidCallback onDelete;

  const IncidentMediaDialog({
    super.key,
    required this.incident,
    required this.onSave,
    required this.onDelete,
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return AlertDialog(
      title: Text(s.editIncidentMedia),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _mediaUrlController,
                decoration: InputDecoration(labelText: s.mediaUrl),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _mediaCoverController,
                decoration: InputDecoration(
                  labelText: s.mediaCover,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: _pickImage,
                  ),
                ),
              ),
              if (_mediaCoverController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.network(
                    _mediaCoverController.text,
                    height: 100,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _hoursController,
                      decoration: const InputDecoration(labelText: 'Hours'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _minutesController,
                      decoration: const InputDecoration(labelText: 'Minutes'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _secondsController,
                      decoration: const InputDecoration(labelText: 'Seconds'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(s.cancel),
        ),
        TextButton(
          onPressed: () {
            print('Delete button pressed');
            widget.onDelete();
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: Text(s.delete),
        ),
        ElevatedButton(
          onPressed: () {
            try {
              final hours = int.tryParse(_hoursController.text) ?? 0;
              final minutes = int.tryParse(_minutesController.text) ?? 0;
              final seconds = int.tryParse(_secondsController.text) ?? 0;
              final totalSeconds = (hours * 3600) + (minutes * 60) + seconds;

              widget.onSave(
                _mediaUrlController.text.isEmpty
                    ? null
                    : _mediaUrlController.text,
                _pickedFile,
                totalSeconds > 0 ? totalSeconds : null,
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Request sent')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: $e')),
              );
            }
          },
          child: Text(s.save),
        ),
      ],
    );
  }
}
