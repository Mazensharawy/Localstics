import 'package:flutter/material.dart';
import 'package:localstics/features/home/navbar_customer.dart';
import 'package:localstics/features/home/navbar_seller.dart';

class UserModeWrapper extends StatefulWidget {
  const UserModeWrapper({super.key});

  @override
  State<UserModeWrapper> createState() => _UserModeWrapperState();
}

class _UserModeWrapperState extends State<UserModeWrapper> {
  bool isSellerMode = false;

  void _switchToSeller() {
    setState(() {
      isSellerMode = true;
    });
  }

  void _switchToCustomer() {
    setState(() {
      isSellerMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSellerMode
        ? NavbarSeller(onSwitchToCustomer: _switchToCustomer)
        : NavBarCustomer(onSwitchToSeller: _switchToSeller);
  }
}
