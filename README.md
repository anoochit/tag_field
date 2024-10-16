# TagFormField

TagFormField is a customizable Flutter widget that allows users to input and display tags in a form field. It provides an intuitive interface for adding tags as a comma-separated list and displays them as interactive chips.

## Features

- Easy input of multiple tags using comma separation
- Display tags as interactive chips
- Remove tags with a single tap
- Customizable input field decoration
- Callback for tag list changes

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  tag_form_field: ^0.0.1
```

Then run:

```
$ flutter pub get
```

## Usage

Import the package in your Dart code:

```dart
import 'package:tag_form_field/tag_form_field.dart';
```

Use the `TagFormField` widget in your Flutter app:

```dart
TagFormField(
  decoration: InputDecoration(
    labelText: 'Enter tags',
    hintText: 'Enter tags separated by commas',
  ),
  onValueChanged: (tags) {
    print('Current tags: $tags');
  },
)
```

## Example

Here's a more complete example of how to use `TagFormField` in a form:

```dart
import 'package:flutter/material.dart';
import 'package:tag_form_field/tag_form_field.dart';

class MyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tag Input Example')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TagFormField(
              decoration: InputDecoration(
                labelText: 'Tags',
                hintText: 'Enter tags separated by commas',
                border: OutlineInputBorder(),
              ),
              onValueChanged: (tags) {
                print('Tags updated: $tags');
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                // Handle form submission
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

## Customization

You can customize the appearance of the `TagFormField` by providing an `InputDecoration` to the `decoration` parameter. This allows you to change the label, hint text, borders, and other visual aspects of the input field.

The chips' appearance is based on the current theme of your app. You can customize this by modifying your app's theme or by extending the `TagFormField` widget to allow for more specific styling options.

## Contributing

Contributions are welcome! If you find a bug or want to add a feature, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.