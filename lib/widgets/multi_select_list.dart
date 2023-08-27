// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MultiSelect<T> extends StatefulWidget {
  final Future<List<T>> itemsFuture;
  final String Function(T) getName;
  const MultiSelect({
    Key? key,
    required this.itemsFuture,
    required this.getName,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState<T>();
}

class _MultiSelectState<T> extends State<MultiSelect<T>> {
  // this variable holds the selected items
  final List<T> _selectedItems = [];

  // This function is triggered when a checkbox is checked or unchecked
  void _itemChange(T item, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(item);
      } else {
        _selectedItems.remove(item);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

  // this function is called when the Submit button is tapped
  void _submit() {
    /* final List<String> result =
        _selectedItems.map((item) => widget.getName(item)).toList(); */
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Items'),
      content: FutureBuilder<List<T>>(
        future: widget.itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: ListBody(
                children: snapshot.data!
                    .map((item) => CheckboxListTile(
                          value: _selectedItems.contains(item),
                          title: Text(widget.getName(item)),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (isChecked) =>
                              _itemChange(item, isChecked!),
                        ))
                    .toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}