import 'package:flutter/material.dart';

typedef ToDoListAddedCallback = Function(
    TextEditingController textConroller, TextEditingController txtcontroller, TextEditingController txtcontrol);

class ToDoDialog extends StatefulWidget {
  const ToDoDialog({
    super.key,
    required this.onListAdded,
  });

  final ToDoListAddedCallback onListAdded;

  @override
  State<ToDoDialog> createState() => _ToDoDialogState();
}

class _ToDoDialogState extends State<ToDoDialog> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Contact To Add'),
      content: Column(children: [
       TextField(
        onChanged: (value) {
          setState(() {
            valueText = value;
          });
        },
        controller: _firstController,
        decoration: const InputDecoration(hintText: "First name"),
      ),
      TextField(
        onChanged: (value) {
          setState(() {
            valueText = value;
          });
        },
        controller: _lastController,
        decoration: const InputDecoration(hintText: "Last name"),
      ),
      TextField(
        onChanged: (value) {
          setState(() {
            valueText = value;
          });
        },
        controller: _numberController,
        decoration: const InputDecoration(hintText: "Phone #"),
        )
      ],
      ),
    
      
      actions: <Widget>[
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          child: const Text('Cancel'),
          onPressed: () {
            setState(() {
              
              Navigator.pop(context);
            });
          },
        ),

        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _firstController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty
                  ? () {
                    
                      setState(() {
                        widget.onListAdded(_firstController, _lastController, _numberController);
                        Navigator.pop(context);
                      });
                    }
                  : null,
              child: const Text('OK'),
            );
          },
        ),
      ],
    );
  }
}
