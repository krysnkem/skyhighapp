import 'package:flutter/material.dart';

class DropDownFilterWidget<T> extends StatelessWidget {
  const DropDownFilterWidget({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.icon,
    this.title,
  });
  final List<DropdownMenuItem<T>> items;
  final T value;
  final ValueChanged<T?> onChanged;
  final Icon? icon;
  final Widget? title;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      if (icon != null) ...[
        icon!,
        const SizedBox(
          width: 5,
        ),
      ],
      if (title != null) ...[
        title!,
        const SizedBox(
          width: 10,
        ),
      ],
      DropdownButton<T>(
        value: value,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: onChanged,
        items: items,
      )
    ]);
  }
}