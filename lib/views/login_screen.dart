import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:tumdum_delivery_app/gen/assets.gen.dart';
import 'package:tumdum_delivery_app/model/resturant.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';
import 'package:tumdum_delivery_app/util/string_constants.dart';
import 'package:tumdum_delivery_app/widget/button_widget.dart';
import 'package:tumdum_delivery_app/widget/text_field.dart';

import '../services/fb_auth_service.dart';
import '../util/style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fKey = GlobalKey<FormState>();
    Restaurant res = Restaurant();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 300,
        automaticallyImplyLeading: false,
        flexibleSpace: Image.asset(
          Assets.images.splash.logo.path,
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
      ),
      body: Form(
        key: fKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  StringConstants.loginText,
                  style: Style.headlineText,
                  textAlign: TextAlign.left,
                ),
              ),
              TextFieldWidget(
                onSaved: (p0) => res.resEmail = p0 ?? "",
                hintText: "Email",
              ),
              TextFieldWidget(
                onSaved: (p0) => res.pass = p0 ?? "",
                hintText: "Password",
              ),
              RichText(
                  text: TextSpan(
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.black,
                      ),
                      text: StringConstants.termsText1,
                      children: const [
                    TextSpan(
                        text: StringConstants.termsText2,
                        style: TextStyle(color: Colors.blue)),
                    TextSpan(text: StringConstants.termsText3),
                    TextSpan(
                        text: StringConstants.termsText4,
                        style: TextStyle(color: Colors.blue))
                  ])),
              ButtonWidget(
                  onPressed: () async {
                    FToast().init(context);
                    final fState = fKey.currentState;
                    if (fState!.validate()) {
                      context.loaderOverlay.show();

                      fState.save();
                      final restaurant =
                          await FbAuthService.signInWithEmailAndPassword(res);
                      if (context.mounted) {
                        context.loaderOverlay.hide();
                        if (restaurant != null) {
                          Navigator.of(context).pushReplacementNamed(
                              RouteGenerator.restaurantLocationUpdatePage,
                              arguments: restaurant);
                        }
                      }
                    }
                  },
                  text: "Login"),
            ],
          ),
        ),
      ),
    );
  }
}
