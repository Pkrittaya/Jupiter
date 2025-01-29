import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class DropdownForm extends StatelessWidget {
  final SingleValueDropDownController? controller;
  final List<DropDownValueModel> dropDownList;
  final void Function(dynamic)? onChanged;
  final String label;
  final String hint;

  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Color? fillColor;

  const DropdownForm({
    Key? key,
    required this.dropDownList,
    required this.label,
    required this.hint,
    this.controller,
    this.onChanged,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      // initialValue: "name4",
      controller: controller,
      clearOption: false,
      enableSearch: false,
      clearIconProperty: IconProperty(color: Colors.green),
      searchDecoration: InputDecoration(hintText: hint),
      // textFieldDecoration: InputDecoration(hintText: hint),
      textFieldDecoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        // prefixIcon: icon,
        hintText: hint,
        labelText: label,
        labelStyle: labelStyle,
        hintStyle: hintStyle,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
      ),
      textStyle: style,
      validator: (value) {
        if (value == null || value == "") {
          return "Required field";
        } else {
          return null;
        }
      },
      dropDownItemCount: dropDownList.length,
      dropDownList: dropDownList,
      onChanged: onChanged,
    );
  }
}
