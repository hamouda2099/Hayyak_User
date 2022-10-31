import 'package:flutter/material.dart';

void loadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.black.withOpacity(0.3),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Waiting..',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Center(
              child: CircularProgressIndicator(
            strokeWidth: 1,
            color: Colors.white,
          ))
        ],
      ),
    ),
  );
}
