import 'package:flutter/material.dart';

enum ToastType { success, error, info, warning }

void SnackToastMessage(BuildContext context, String message, ToastType type) {
  Color borderColor;
  Color iconColor;
  IconData icon;
  String title;

  // Set styles based on the toast type
  switch (type) {
    case ToastType.success:
      borderColor = Colors.green;
      iconColor = Colors.green;
      icon = Icons.check_circle_outline;
      title = "Berhasil";
      break;
    case ToastType.error:
      borderColor = Colors.red;
      iconColor = Colors.red;
      icon = Icons.error_outline;
      title = "Gagal";
      break;
    case ToastType.info:
      borderColor = Colors.blue;
      iconColor = Colors.blue;
      icon = Icons.info_outline;
      title = "Info";
      break;
    case ToastType.warning:
      borderColor = Colors.orange;
      iconColor = Colors.orange;
      icon = Icons.warning_amber_outlined;
      title = "Perhatian";
      break;
  }

  // Create an overlay entry
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 40,
      right: 20,
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 300),
        child: Material(
          color: Colors.transparent,
          child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            child: Container(
              width: 350,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border(
                  left: BorderSide(width: 5, color: borderColor),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon
                  Icon(icon, color: iconColor, size: 28),
                  SizedBox(width: 12),
                  // Text Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          message,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Close Button
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  // Insert the overlay entry into the Overlay
  Overlay.of(context)?.insert(overlayEntry);

  // Auto-remove the toast after 4 seconds with fade-out effect
  Future.delayed(Duration(seconds: 4), () {
    overlayEntry.remove();
  });
}
