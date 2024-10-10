import 'package:flutter/material.dart';

class TagFieldWidget extends StatefulWidget {
  const TagFieldWidget({super.key, this.decoration, this.valueChange});

  final InputDecoration? decoration;
  final ValueChanged<List<String>>? valueChange;

  @override
  State<TagFieldWidget> createState() => _TagFieldWidgetState();
}

class _TagFieldWidgetState extends State<TagFieldWidget> {
  List<String> values = [];

  TextEditingController tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: tagController,
          decoration: widget.decoration,
          maxLines: 1,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            if (value.contains(',')) {
              setState(() {
                value.split(',').forEach((e) {
                  final labal = e.trim();
                  if (!values.contains(labal)) {
                    if (labal.isNotEmpty) {
                      values.add(labal);
                    }
                  }
                });
                tagController.clear();
                widget.valueChange?.call(values);
              });
            }
          },
        ),
        const SizedBox(
          height: 8.0,
        ),
        (values.isNotEmpty)
            ? Wrap(
                children: List.generate(values.length, (i) {
                  return buildChip(values[i], i);
                }),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget buildChip(String labal, int index) {
    return Container(
      margin: const EdgeInsets.only(right: 4.0, top: 4.0, bottom: 4.0),
      child: Chip(
          label: Text(labal),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          deleteIcon: const Icon(Icons.remove_circle),
          onDeleted: () {
            setState(() {
              values.removeAt(index);
              widget.valueChange?.call(values);
            });
          }),
    );
  }
}
