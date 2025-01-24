import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final void Function(List<String>) onChanged;

  const LanguageSelector({
    super.key,
    required this.options,
    this.selectedOptions = const [],
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showLanguageDialog(context),
      child: const Text('Idioma do host'),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return _LanguageDialog(
          options: options,
          selectedOptions: selectedOptions,
          onChanged: onChanged,
        );
      },
    );
  }
}

class _LanguageDialog extends StatefulWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final void Function(List<String>) onChanged;

  const _LanguageDialog({
    required this.options,
    this.selectedOptions = const [],
    required this.onChanged,
  });

  @override
  __LanguageDialogState createState() => __LanguageDialogState();
}

class __LanguageDialogState extends State<_LanguageDialog> {
  late List<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected =
        List<String>.from(widget.selectedOptions.where((e) => e.isNotEmpty));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Selecione o idioma do host',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.options.length,
              itemBuilder: (context, index) {
                final option = widget.options[index];
                return CheckboxListTile(
                  title: Text(option),
                  value: _selected.contains(option),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true && option.isNotEmpty) {
                        _selected.add(option);
                      } else {
                        _selected.remove(option);
                      }
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                widget.onChanged(_selected);
                Navigator.of(context).pop();
              },
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
