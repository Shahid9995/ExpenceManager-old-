import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util/dimensions.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  // final FocusNode focusNode;
  // final FocusNode nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  // final Function onChanged;
  // final Function onSubmit;
  final bool isEnabled;
  final bool isVerification;
  final bool isUserName;
  final int maxLines;
  final TextCapitalization capitalization;
  final String prefixIcon;
  final bool isSuffixIcon;
  final bool isprefixIcon;
  final Widget suffixIcon;
  final bool divider;
  final double padding;

  CustomTextField(
      {this.hintText = 'Write something...',
        required this.controller,
        this.isVerification=false,
        this.isUserName=false,
        this.isSuffixIcon=true,
        this.isprefixIcon=true,
        // this.focusNode,
        // this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        // required this.onSubmit,
        // this.onChanged,
        required this.prefixIcon,
        required this.suffixIcon,
        this.capitalization = TextCapitalization.none,
        this.isPassword = false,
        this.padding=1.5,
        this.divider = false, }
      );

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText =true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          // keyboardType: TextInputType.multiline,

          maxLines: widget.maxLines,
          controller: widget.controller,
          // focusNode: widget.focusNode,
          // style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
          textInputAction: widget.inputAction,
          keyboardType: widget.inputType,
          // cursorColor: Theme.of(context).primaryColor,
          // textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: false,
          autofillHints: widget.inputType == TextInputType.name ? [AutofillHints.name]
              : widget.inputType == TextInputType.emailAddress ? [AutofillHints.email]
              : widget.inputType == TextInputType.phone ? [AutofillHints.telephoneNumber]
              : widget.inputType == TextInputType.streetAddress ? [AutofillHints.fullStreetAddress]
              : widget.inputType == TextInputType.url ? [AutofillHints.url]
              : widget.inputType == TextInputType.visiblePassword ? [AutofillHints.password] : null,

          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters: widget.inputType == TextInputType.phone ?!widget.isVerification?
          <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))]: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))]: null,
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.kBlack.withOpacity(0.2)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.kPrimary),
              ),
            isDense: true,
            hintText: widget.hintText,
            fillColor: AppColors.kWhite,
            // fillColor: Theme.of(context).cardColor,
            // hintStyle: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).hintColor),
            filled: true,
              prefixIcon: widget.prefixIcon != "null" ? Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL*widget.padding),
                child: Image.asset(widget.prefixIcon, height: 20, width: 20,color: AppColors.kBlack,),
              ) : null,

            suffixIcon: (widget.isSuffixIcon)?(widget.isPassword || widget.isUserName) ? IconButton(
              icon: Icon(widget.isUserName?!_obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined:_obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,size: 25, color: Theme.of(context).hintColor.withOpacity(0.3)),
              onPressed: _toggle,
            ) :!widget.isVerification?
            widget.suffixIcon:null:null
          ),
          // onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
          //     : widget.onSubmit != null ? widget.onSubmit(text) : null,
          // onChanged: widget.onChanged,
        ),

        widget.divider ? Padding(padding: EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalLg), child: const Divider()) : const SizedBox(),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
