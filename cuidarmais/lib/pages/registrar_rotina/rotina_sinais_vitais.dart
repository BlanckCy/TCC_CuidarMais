import 'package:flutter/material.dart';
import 'package:cuidarmais/widgets/customAppBar.dart';

class SinaisVitaisPage extends StatefulWidget {
  @override
  _SinaisVitaisPageState createState() => _SinaisVitaisPageState();
}

class _SinaisVitaisPageState extends State<SinaisVitaisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
    );
  }
}
