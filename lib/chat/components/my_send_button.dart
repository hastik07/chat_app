import 'package:flutter/material.dart';

class MySendButton extends StatelessWidget {
  const MySendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(offset: Offset(-4, -4), color: Colors.white),
          BoxShadow(offset: Offset(4, 4), color: Colors.grey),
        ],
        color: Colors.grey.shade100,
      ),
      child: Icon(Icons.send, size: 30),
    );
  }
}
