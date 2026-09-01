import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key,
  this.height,
  this.width,
    this.hintText, required this.isPassword, required this.controller, this.label, this.icon});
final String? hintText;
final bool isPassword;
final String? label;
final IconData? icon;
final TextEditingController controller;
final double? height;
final double? width;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
     return SizedBox(
      height: widget.height ?? 60,
      width: widget.width ?? 300,
       child: TextFormField(
        controller: widget.controller,
         cursorHeight: 20,
         cursorColor: Colors.black,
         validator: (v) {
          if(v == null || v.isEmpty){
           return "Please Fill ${widget.hintText}";
          }
          null;
          return null;
         },
         obscureText:_obscureText ,
         
         decoration: InputDecoration(
           prefixIcon:Icon( widget.icon),
           enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:  BorderSide(color: AppColors.grayColor),
           ),
           focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:  BorderSide(color: AppColors.grayColor),
           ),
           hintText: widget.hintText,
           labelText: widget.label,
           hintStyle: const TextStyle(color: Colors.black),
           fillColor: Colors.white,
           filled: true,
           suffixIcon:  widget.isPassword
           ? GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText 
                ? CupertinoIcons.eye_slash  
                : CupertinoIcons.eye,        
            color: AppColors.textColor,
          ),
        )
           : null,
         ),
       ),
     );

  }
}