import 'package:flutter/material.dart';
import 'package:yd8/modules/emp_manager/ui/components/widgets/custom_form_text_field.dart';

class KeyValuePairControllers {
  final TextEditingController keyController;
  final TextEditingController valueController;

  KeyValuePairControllers()
    : keyController = TextEditingController(),
      valueController = TextEditingController();

  void dispose() {
    keyController.dispose();
    valueController.dispose();
  }
}

class KeyValueForm extends StatefulWidget {
  final List<KeyValuePairControllers> items;

  const KeyValueForm({super.key, required this.items});

  @override
  State<KeyValueForm> createState() => _KeyValueFormState();
}

class _KeyValueFormState extends State<KeyValueForm> {
  final ScrollController _scrollController = ScrollController();

  void _addItem() {
    setState(() {
      widget.items.add(KeyValuePairControllers());
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent +
              100, // Adjust scroll amount as needed
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _removeItem(int index) {
    // IMPORTANT: Dispose controllers before removing

    widget.items[index].dispose();
    setState(() {
      widget.items.removeAt(index);
    });
  }

  @override
  void dispose() {
    for (var item in widget.items) {
      item.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.items.isEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No fields added yet',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Field'),
                onPressed: _addItem,
              ),
            ],
          )
        else
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final keyController = widget.items[index].keyController;
                final valueController = widget.items[index].valueController;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomFormTextField(
                          controller: keyController,
                          labelText: 'Key',
                          isOptional: true,
                          validator: (input) {
                            if (input?.isNotEmpty == true &&
                                valueController.text.isEmpty) {
                              return 'Value is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CustomFormTextField(
                          controller: valueController,
                          labelText: 'Value',
                          isOptional: true,
                          validator: (input) {
                            if (input?.isNotEmpty == true &&
                                keyController.text.isEmpty) {
                              return 'Key is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                        ),
                        onPressed: () => _removeItem(index),
                        tooltip: 'Remove field',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        if (widget.items.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Field'),
              onPressed: _addItem,
            ),
          ),
      ],
    );
  }
}
