import 'package:flutter/material.dart';

class content extends StatefulWidget {
  content(
      {super.key,
      this.id,
      required this.titlecontent,
      required this.desc,
      required this.onPress,
      // required this.date,
      this.isDone});

  int? id;
  final String titlecontent;
  final String desc;
  bool? isDone;
  final Function onPress;
  // final String date;

  @override
  State<content> createState() => _contentState();
}

class _contentState extends State<content> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.titlecontent),
      subtitle: Text(widget.desc),
      // trailing: Text(widget.date),
      trailing: IconButton(
          onPressed: () => widget.onPress(), icon: Icon(Icons.delete)),
      contentPadding: EdgeInsets.all(8),
    );
  }
}
