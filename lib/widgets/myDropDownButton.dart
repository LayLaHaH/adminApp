// ignore_for_file: file_names

/* import 'package:flutter/material.dart';

class EntityDropdown<T> extends StatefulWidget {
  final Future<List<T>> entitiesFuture;
  final T selectedEntity;
  late final String entityIdController;
  final String labelText;
  final String Function(T) getEntityName;

  const EntityDropdown({
    super.key,
    required this.entitiesFuture,
    required this.selectedEntity,
    required this.entityIdController,
    required this.labelText,
    required this.getEntityName,
  });

  @override
  _EntityDropdownState<T> createState() => _EntityDropdownState<T>();
}

class _EntityDropdownState<T> extends State<EntityDropdown<T>> {
  late T _selectedEntity;

  @override
  void initState() {
    _selectedEntity = widget.selectedEntity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.entitiesFuture,
      builder: (BuildContext context, AsyncSnapshot<List<T>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return TextButton(
            onPressed: () {},
            child: const Text("loading.."),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return DropdownButtonFormField<T>(
            items: snapshot.data.map((entity) => DropdownMenuItem<T>(
              value: entity,
              child: Text(widget.getEntityName(entity)),
            )).toList(),
            decoration: InputDecoration(labelText: widget.labelText),
            onChanged: (value) {
              setState(() {
                _selectedEntity = value!;
                widget.entityIdController = widget.getEntityId(value).toString();
                print(widget.getEntityId(value));
              });
            },
            value: _selectedEntity,
            validator: (value) {
              if (value == null) {
                return 'Please select an entity';
              }
              return null;
            },
          );
        }
      },
    );
  }
} */