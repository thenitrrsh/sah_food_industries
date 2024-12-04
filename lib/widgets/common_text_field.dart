import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool isRequired;
  final String? validatorText;

  final String? title;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final String Function(String?)? validator;
  final bool? readonly;
  final int? maxLength;

  const CommonTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isRequired = false,
    this.validatorText,
    this.title,
    this.readonly,
    this.inputFormatters,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null) ...<Widget>[
          Row(
            children: <Widget>[
              Text(
                title ?? '',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 15,
                    ),
              ),
              if (isRequired)
                Text(
                  ' *',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 15, color: Colors.red),
                ),
            ],
          ),
          const SizedBox(height: 10),
        ],
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Platform.isIOS
              ? _buildCupertinoTextField()
              : _buildMaterialTextField(context),
        ),
      ],
    );
  }

  Widget _buildMaterialTextField(context) {
    return Consumer(builder: (context, ref, child) {
      return TextFormField(
        readOnly: readonly ?? false,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        cursorColor: Theme.of(context).colorScheme.onSecondary,
        onSaved: onSaved,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator ??
            (isRequired
                ? (String? value) {
                    if (value?.isEmpty ?? false) {
                      return validatorText ?? 'This field is required';
                    }
                    return null;
                  }
                : null),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15),
          // labelText: hintText,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.blueGrey,
          ),
          counterText: '',
        ),
      );
    });
  }

  Widget _buildCupertinoTextField() {
    return CupertinoTextField(
      inputFormatters: inputFormatters,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      placeholder: hintText,
      readOnly: readonly ?? false,
      padding: const EdgeInsets.all(10),
      onEditingComplete: onEditingComplete,
      onSubmitted: onFieldSubmitted,
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.systemGrey),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
