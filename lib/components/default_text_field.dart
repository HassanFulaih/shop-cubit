import 'package:flutter/material.dart';

class DefaultTextField extends StatefulWidget {
  const DefaultTextField({
    Key? key,
    this.isClickable = true,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    required this.label,
    required this.type,
    required this.controller,
    required this.prefix,
    this.suffix,
    this.suffixPress,
    this.isPassword = false,
    required this.validate,
  }) : super(key: key);

  final String label;
  final TextInputType type;
  final TextEditingController controller;
  final IconData prefix;
  final IconData? suffix;
  final Function()? suffixPress;
  final bool isPassword;
  final bool isClickable;
  final String? Function(String?)? validate;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        enabled: widget.isClickable,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          gapPadding: 4.0,
        ),
        labelText: widget.label,
        prefixIcon: Icon(widget.prefix),
        suffixIcon: widget.suffix == null
            ? null
            : IconButton(
                icon: Icon(widget.suffix),
                onPressed: widget.suffixPress,
              ),
      ),
      onTap: widget.onTap,
      obscureText: widget.isPassword,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      keyboardType: widget.type,
      validator: widget.validate,
    );
  }
}
