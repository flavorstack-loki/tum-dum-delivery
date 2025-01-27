// import 'package:flutter/material.dart';
// import 'package:tumdum_delivery_app/navigation/routes.dart';
// import 'package:tumdum_delivery_app/util/string_constants.dart';
// import 'package:tumdum_delivery_app/util/style.dart';
// import 'package:tumdum_delivery_app/widget/info_card_widget.dart';

// class InfoScreen extends StatelessWidget {
//   const InfoScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   toolbarHeight: 160,
      //   flexibleSpace: Container(
      //     height: 230,
      //     padding: const EdgeInsets.symmetric(horizontal: 20),
      //     width: double.maxFinite,
      //     decoration: BoxDecoration(
      //         color: const Color(0xff78192D),
      //         borderRadius: BorderRadius.circular(30)),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       spacing: 10,
      //       children: [
      //         Text("Welcome to TumDum",
      //             style: Style.headlineText.copyWith(color: Colors.white)),
      //         Text(
      //             "Just a few steps to complete and then you can start earning with us",
      //             style: Style.headlineText
      //                 .copyWith(color: Colors.white, fontSize: 16)),
      //       ],
      //     ),
      //   ),
      // ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           spacing: 10,
//           children: [
//             const Text(
//               StringConstants.pendingDocumentsText,
//               style: Style.headlineText,
//             ),
//             InfoCardWidget(
//               text: StringConstants.personalInfo,
//               onPressed: () => Navigator.of(context)
//                   .pushNamed(RouteGenerator.personalInfoPage),
//             ),
//             InfoCardWidget(
//               text: StringConstants.personalDocumentsText,
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
