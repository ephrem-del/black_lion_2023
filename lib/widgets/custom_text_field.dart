import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String? Function(String?)? validate;
  final bool? number;
  const CustomTextField({
    super.key,
    required this.title,
    required this.validate,
    required this.controller,
    this.number
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: Get.width * 0.8,
          child: Stack(
            children: [
              Container(
                width: Get.width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
              TextFormField(
                keyboardType: widget.number != null && widget.number == true ? const TextInputType.numberWithOptions() : null,
                inputFormatters: widget.number != null && widget.number == true ? [
                  FilteringTextInputFormatter.digitsOnly,
                ] : null,
                controller: widget.controller,
                validator: widget.validate,
              
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
