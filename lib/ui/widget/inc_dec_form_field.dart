import 'package:ecom/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class IncDecFormField extends StatefulWidget {
  const IncDecFormField({
    super.key,
    required this.onChange,
  });

  final Function(int) onChange;

  @override
  State<IncDecFormField> createState() => _IncDecFormFieldState();
}

class _IncDecFormFieldState extends State<IncDecFormField> {
  int currentValue = 1;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = currentValue.toString();
    controller.addListener(() {
      widget.onChange(currentValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            currentValue++;
            controller.text = currentValue.toString();
          },
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(4)),
            child: const Icon(
              Icons.add,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            readOnly: true,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        GestureDetector(
          onTap: () {
            if (currentValue > 1) {
              currentValue--;
              controller.text = currentValue.toString();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(4)),
            child: const Icon(
              Icons.remove,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
