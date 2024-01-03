import 'package:flutter/material.dart';
import 'package:otoserve/src/presentation/router/routes.dart';
import 'package:otoserve/src/presentation/screen/home/widgets/services_type_widget.dart';

class ServiceWidget extends StatefulWidget {
  const ServiceWidget({super.key});

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ServicesTypeWidget(
          image: 'assets/icons/siren.png',
          text: 'Emergency\nService',
          onTap: () {
            Navigator.pushNamed(context, Routes.emergencyServiceScreen);
          },
        ),
        ServicesTypeWidget(
          image: 'assets/icons/service.png',
          text: 'Home\nService',
          onTap: () {
            Navigator.pushNamed(context, Routes.homeServiceScreen);
          },
        ),
        ServicesTypeWidget(
          image: 'assets/icons/location.png',
          text: 'Find\nBengkel',
          onTap: () {
            Navigator.pushNamed(context, Routes.findBengkelScreen);
          },
        ),
      ],
    );
  }
}
