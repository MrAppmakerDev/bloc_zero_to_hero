import 'dart:ui';

import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final String? text;
  final double width;
  final double height;
  const CustomLoader({
    super.key,
    this.text,
    this.width = 200,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),
                if (text != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    text!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
