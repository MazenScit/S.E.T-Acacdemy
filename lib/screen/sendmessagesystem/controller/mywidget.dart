
import 'package:flutter/material.dart';
Container textform(controllerText, String Title, TextInputType type, validator,IconData? icon) {
  
    return Container(
      height: 60,
      width: double.infinity,
      child: TextFormField(
        validator: validator,
        // textAlign: TextAlign.center,
        obscureText: type == TextInputType.visiblePassword,
        keyboardType: type,
        cursorColor: Colors.black,
        controller: controllerText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.black)),
          
          hintText: Title,
          hintStyle:
              TextStyle(color: Color(0xff8c9289), fontFamily: 'Cobe'),
        ),
      ),
    );
  }
