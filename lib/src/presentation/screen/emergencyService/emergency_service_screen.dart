import 'package:flutter/material.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/layanan_bengkel_widget.dart';

class EmergencyServiceScreen extends StatefulWidget {
  const EmergencyServiceScreen({super.key});

  @override
  State<EmergencyServiceScreen> createState() => _EmergencyServiceScreenState();
}

class _EmergencyServiceScreenState extends State<EmergencyServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return const LayananBengkelWidget();
  }
}
