import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';

class HigienePage extends StatefulWidget {
  @override
  _HigienePageState createState() => _HigienePageState();
}

class _HigienePageState extends State<HigienePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
    );
  }
}
