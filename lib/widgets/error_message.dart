import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String errorMessage;

  const ErrorMessage(
    this.errorMessage, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Column(
        children: [
          Icon(Icons.error, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Error: $errorMessage',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
