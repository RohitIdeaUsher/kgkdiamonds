import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaratFilterWidget extends StatefulWidget {
  final Function(double?, double?) onCaratSelected;
  final TextEditingController fromController;
  final TextEditingController toController;
  const CaratFilterWidget(
      {super.key,
      required this.fromController,
      required this.toController,
      required this.onCaratSelected});

  @override
  _CaratFilterWidgetState createState() => _CaratFilterWidgetState();
}

class _CaratFilterWidgetState extends State<CaratFilterWidget> {
  final _formKey = GlobalKey<FormState>();
  Timer? _debounce;

  double? fromCarat;
  double? toCarat;

  final double minCarat = 0.15;
  final double maxCarat = 50.00;

  void _onChanged(String value, bool isFrom) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        if (isFrom) {
          fromCarat = value.isEmpty ? null : double.tryParse(value);
        } else {
          toCarat = value.isEmpty ? null : double.tryParse(value);
        }
        _validateAndApplyFilter();
      });
    });
  }

  // void _validateAndApplyFilter() {
  //   if (_formKey.currentState!.validate()) {
  //     if (fromCarat == null && toCarat == null) {
  //       widget.onCaratSelected(null, null); // Pass null when both are empty
  //     } else if (fromCarat != null && toCarat == null) {
  //       widget.onCaratSelected(
  //           fromCarat, maxCarat); // Assume max value for missing "to"
  //     } else if (fromCarat == null && toCarat != null) {
  //       widget.onCaratSelected(
  //           minCarat, toCarat); // Assume min value for missing "from"
  //     } else if (fromCarat != null &&
  //         toCarat != null &&
  //         fromCarat! <= toCarat!) {
  //       widget.onCaratSelected(fromCarat, toCarat);
  //     }
  //   }
  // }

  void _validateAndApplyFilter() {
    if (_formKey.currentState!.validate()) {
      double? from = fromCarat ?? minCarat; // Default to min if null
      double? to = toCarat ?? maxCarat; // Default to max if null

      if (fromCarat == null && toCarat == null) {
        widget.onCaratSelected(null, null); // Pass null when both are empty
      } else if (fromCarat != null && toCarat == null) {
        widget.onCaratSelected(from, maxCarat); // "To" field is empty, use max
      } else if (fromCarat == null && toCarat != null) {
        widget.onCaratSelected(minCarat, to); // "From" field is empty, use min
      } else if (fromCarat != null && toCarat != null) {
        if (fromCarat! <= toCarat!) {
          widget.onCaratSelected(fromCarat, toCarat);
        } else {
          // Swap values if "From" is greater than "To"
          widget.onCaratSelected(toCarat, fromCarat);
        }
      }
    }
  }

  String? _validateFrom(String? value) {
    if (value == null || value.isEmpty) return null; // Allow empty value
    final double? val = double.tryParse(value);
    if (val == null) return "Invalid number";
    if (val < minCarat) return "Min value is $minCarat";
    if (toCarat != null && val > toCarat!) return "Must be ≤ To value";
    return null;
  }

  String? _validateTo(String? value) {
    if (value == null || value.isEmpty) return null; // Allow empty value
    final double? val = double.tryParse(value);
    if (val == null) return "Invalid number";
    if (val > maxCarat) return "Max value is $maxCarat";
    if (fromCarat != null && val < fromCarat!) return "Must be ≥ From value";
    return null;
  }

  // void _onFilterChanged() {
  //   double? from = double.tryParse(widget.fromController.text);
  //   double? to = double.tryParse(widget.toController.text);
  //   widget.onCaratSelected(from, to);
  // }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.fromController.dispose();
    widget.toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Carat",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          Form(
            key: _formKey,
            child: Row(
              children: [
                _commonTextFiled(
                  widget.fromController,
                  "From Carat",
                  _validateFrom,
                  (value) => _onChanged(value, true),
                ),
                SizedBox(width: 10.w),
                _commonTextFiled(widget.toController, "To Carat", _validateTo,
                    (value) => _onChanged(value, false)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _commonTextFiled(
    TextEditingController controller,
    String hintText,
    String? Function(String?)? validator,
    Function(String)? onChanged,
  ) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        validator: validator, //,
        decoration: InputDecoration(
          labelText: hintText,
          // errorBorder: _errorBorder(),
          enabledBorder: _commonBorder(),
          focusedBorder: _commonBorder(),
        ),
        keyboardType: TextInputType.number,
        onChanged: onChanged, //(value) => _onChanged(value, false),
      ),
    );
  }

  OutlineInputBorder _commonBorder() {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(16));
  }
}
