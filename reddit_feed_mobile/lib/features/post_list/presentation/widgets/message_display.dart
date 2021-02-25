import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String message;

  const MessageWidget({
    @required this.message,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: Text(message),
      ),
    );
  }
}
