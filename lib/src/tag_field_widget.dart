import 'package:flutter/material.dart';

/// A form field widget for inputting and displaying tags.
///
/// This widget allows users to input tags as a comma-separated list
/// and displays them as chips. Users can also remove tags by tapping
/// on the delete icon in each chip.
class TagFormField extends StatefulWidget {
  /// Creates a [TagFormField].
  ///
  /// The [decoration] parameter can be used to customize the appearance
  /// of the input field.
  ///
  /// The [onValueChanged] callback is called whenever the list of tags
  /// is modified.
  const TagFormField({
    super.key,
    this.decoration,
    this.onValueChanged,
  });

  /// The decoration to show around the text field.
  final InputDecoration? decoration;

  /// Called when the list of tags changes.
  final ValueChanged<List<String>>? onValueChanged;

  @override
  State<TagFormField> createState() => _TagFormFieldState();
}

class _TagFormFieldState extends State<TagFormField> {
  /// The list of current tags.
  final List<String> _tags = [];

  /// Controller for the text input field.
  final TextEditingController _tagController = TextEditingController();

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  /// Adds new tags from the input value.
  ///
  /// This method splits the input by commas, trims whitespace,
  /// removes duplicates, and adds new tags to the list.
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

  /// Removes a tag at the specified index.
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

  /// Builds a chip widget for a single tag.
  ///
  /// The chip includes the tag label and a delete button.
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
