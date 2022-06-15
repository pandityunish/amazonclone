import 'package:flutter/material.dart';

class Accountbutton extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;
  const Accountbutton({Key? key, required this.text, required this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0),
            borderRadius: BorderRadius.circular(50),
            color: Colors.white),
        child: OutlinedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.03),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                )),
            onPressed: onpressed,
            child: Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.black),
            )),
      ),
    );
  }
}
