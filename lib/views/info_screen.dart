import 'package:flutter/material.dart';
import 'package:tumdum_delivery_app/util/style.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        flexibleSpace: Container(
          height: 250,
          padding: const EdgeInsets.all(20),
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color(0xff78192D),
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text("Welcome to TumDum",
                  style: Style.headlineText.copyWith(color: Colors.white)),
              Text(
                  "Just a few steps to complete and then you can start earning with us",
                  style: Style.headlineText
                      .copyWith(color: Colors.white, fontSize: 16)),
            ],
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              "Pending Documents",
              style: Style.headlineText,
            )
          ],
        ),
      ),
    );
  }
}
