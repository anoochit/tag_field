import 'package:flutter/material.dart';

class TagFormField extends StatefulWidget {
  const TagFormField({
    super.key,
    this.decoration,
    this.onValueChanged,
  });

  final InputDecoration? decoration;
  final ValueChanged<List<String>>? onValueChanged;

  @override
  State<TagFormField> createState() => _TagFormFieldState();
}

class _TagFormFieldState extends State<TagFormField> {
  final List<String> _tags = [];
  final TextEditingController _tagController = TextEditingController();

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  void _addTags(String value) {
    final newTags = value
        .split(',')
        .map((e) => e.trim())
        .where((tag) => tag.isNotEmpty && !_tags.contains(tag))
        .toList();

    if (newTags.isNotEmpty) {
      setState(() {
        _tags.addAll(newTags);
        _tagController.clear();
      });
      widget.onValueChanged?.call(_tags);
    }
  }

  void _removeTag(int index) {
    setState(() {
      _tags.removeAt(index);
    });
    widget.onValueChanged?.call(_tags);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _tagController,
          decoration: widget.decoration,
          maxLines: 1,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            if (value.contains(',')) {
              _addTags(value);
            }
          },
        ),
        const SizedBox(height: 8.0),
        if (_tags.isNotEmpty)
          Wrap(
            children: _tags
                .asMap()
                .entries
                .map((entry) => _buildChip(entry.value, entry.key))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildChip(String label, int index) {
    return Container(
      margin: const EdgeInsets.only(right: 4.0, top: 4.0, bottom: 4.0),
      child: Chip(
        label: Text(label),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        deleteIcon: const Icon(Icons.remove_circle),
        onDeleted: () => _removeTag(index),
      ),
    );
  }
}
