import 'package:flutter/material.dart';

typedef ToDoListAddedCallback = Function(
    String value,
    String value2,
    String value3,
    TextEditingController textConroller,
    TextEditingController textController2,
    TextEditingController textController3);

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
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _inputController2 = TextEditingController();
  final TextEditingController _inputController3 = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";
  String valueText2 = "";
  String valueText3 = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Concert'),
      content: Column(children: [
        TextField(
          key: const Key("ConcertField"),
          onChanged: (value) {
            setState(() {
              valueText = value;
            });
          },
          controller: _inputController,
          decoration: const InputDecoration(hintText: "Artist Name"),
        ),
        TextField(
          key: const Key("DateField"),
          onChanged: (value2) {
            setState(() {
              valueText2 = value2;
            });
          },
          controller: _inputController2,
          decoration: const InputDecoration(hintText: "Concert Date"),
        ),
        //added concert venue as a field
        TextField(
          key: const Key("VenueField"),
          onChanged: (value3) {
            setState(() {
              valueText3 = value3;
            });
          },
          controller: _inputController3,
          decoration: const InputDecoration(hintText: "Concert Venue"),
        ),
      ]),
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
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty
                  ? () {
                      setState(() {
                        widget.onListAdded(
                            valueText,
                            valueText2,
                            valueText3,
                            _inputController,
                            _inputController2,
                            _inputController3);
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
