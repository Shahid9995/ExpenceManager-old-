import 'package:flutter/material.dart';

import '../view/screens/authScreen/login_screen.dart';
import 'app_color.dart';
// enum SingingCharacter { PhoneNumber, emailAddress }
class CustomRadio extends StatefulWidget {
  final SingingCharacter value;
  final SingingCharacter? groupValue;
  final void Function(SingingCharacter) onChanged;
  const CustomRadio({Key? key, required this.value, required this.groupValue, required this.onChanged})
      : super(key: key);

  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  // SingingCharacter? _character = SingingCharacter.emailAddress;
  @override
  Widget build(BuildContext context) {
    bool selected = (widget.value == widget.groupValue);

    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: AppColors.kBlack.withOpacity(0.2)),
            // color: selected ? Colors.white : Colors.grey[200]
        ),
        child: Icon(
          Icons.circle,
          size: 12,
          color: selected ? AppColors.kPrimary :AppColors.kWhite,
        ),
      ),
    );
  }
}