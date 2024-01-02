import 'dart:io';

import 'package:flutter/material.dart';

class val {
  void signUpExpert(
      typeuser,
      String UsernameController,
      String PassController,
      String ConPassController,
      String LnameController,
      String FnameController,
      String phoneController,
      String EmailController,
      String LocationController,
      String MajorController,
      // String image,
      context) async {
    String _user = UsernameController.trim();
    String _Lname = LnameController.trim();
    String _fname = FnameController.trim();
    String _phone = phoneController.trim();
    String _email = EmailController.trim();
    String _pass = PassController.trim();
    String _conpass = ConPassController.trim();
    String _location = LocationController.trim();
    String _Major = MajorController.trim();
    // String _image = image;

    String type = typeuser;

    if (_fname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('First Name MUST BE REQUIRED'),
        backgroundColor: Colors.red,
      ));
    } else if (_Lname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Last Name MUST BE REQUIRED'),
        backgroundColor: Colors.red,
      ));
    } else if (_user.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User Name MUST BE REQUIRED'),
        backgroundColor: Colors.red,
      ));
    } else if (_phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Phone Number MUST BE REQUIRED'),
        backgroundColor: Colors.red,
      ));
    } else if (_phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('The phone must be at least 10 characters.'),
        backgroundColor: Colors.red,
      ));
    } else if (_email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Email MUST BE REQUIRED'),
        backgroundColor: Colors.red,
      ));
    } else if (_pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password MUST BE REQUIRED'),
        backgroundColor: Colors.red,
      ));
    } else if (_pass.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('The password must be at least 5 characters'),
        backgroundColor: Colors.red,
      ));
    } else if (_pass != _conpass) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('password does not match'),
        backgroundColor: Colors.red,
      ));
    } else if (_Major.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Major MUST BE REQUIRED'),
        backgroundColor: Colors.red,
      ));
    } else {
      // _user_control.registerExpert(
      //     type, _user, _fname, _Lname, _phone, _email, _pass, _Major, context);
    }
  }

  void signUpFarmer(
      typeuser,
      UsernameController,
      PassController,
      ConPassController,
      LnameController,
      FnameController,
      phoneController,
      EmailController,
      LocationController,
      // String image,
      context) async {
    String _user = UsernameController;
    String _password = PassController;
    String _conPass = ConPassController;
    String _Lname = LnameController;
    String _fname = FnameController;
    String _phone = phoneController;
    String _email = EmailController;
    String _pass = PassController;
    String _location = LocationController;
    // String _image = image;

    String type = typeuser;

    if (_fname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('First Name MUST BE REQUIRED'),
        backgroundColor: Colors.red,
      ));
    } else if (_Lname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Last Name MUST BE REQUIRED'),
        backgroundColor: Colors.red,
      ));
    } else if (_user.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User Name MUST BE REQUIRED'),
        backgroundColor: Colors.red,
      ));
    } else if (_phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Phone Number MUST BE REQUIRED'),
        backgroundColor: Colors.red,
      ));
    } else if (_phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('The phone must be at least 10 characters.'),
        backgroundColor: Colors.red,
      ));
    } else if (_email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Email MUST BE REQUIRED'),
        backgroundColor: Colors.red,
      ));
    } else if (_pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password MUST BE REQUIRED'),
        backgroundColor: Colors.red,
      ));
    } else if (_pass.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('The password must be at least 5 characters'),
        backgroundColor: Colors.red,
      ));
    } else if (_pass != _conPass) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('password does not match'),
        backgroundColor: Colors.red,
      ));
    } else {
      // _user_control.registerFarmer(
      //     typeuser, _fname, _Lname, _user, _phone, _email, _password, context);
    }
  }
}
