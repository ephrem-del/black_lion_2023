import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final bool loading;
  final Function onPressed;
  const CustomButton(
      {super.key,
      required this.loading,
      required this.onPressed,
      required this.title});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.8,
      height: 40,
      child: ElevatedButton(
        onPressed: widget.loading
            ? null
            : () {
                widget.onPressed();
              },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black54),
        child: widget.loading
            ? Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: const CircularProgressIndicator(
                  color: Colors.white,
                              ),
                ))
            : Center(
                child: Text(
                  widget.title,
                ),
              ),
      ),
    );
  }
}
