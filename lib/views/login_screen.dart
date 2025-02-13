import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:tumdum_delivery_app/gen/assets.gen.dart';
import 'package:tumdum_delivery_app/main.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';
import 'package:tumdum_delivery_app/services/fb_db_services.dart';
import 'package:tumdum_delivery_app/services/message_service.dart';
import 'package:tumdum_delivery_app/util/string_constants.dart';
import 'package:tumdum_delivery_app/widget/button_widget.dart';
import 'package:tumdum_delivery_app/widget/text_field.dart';

import '../util/style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fKey = GlobalKey<FormState>();
    String email = "";
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
                  onSaved: (p0) => email = p0 ?? "", hintText: "Email"),
              ButtonWidget(
                  onPressed: () async {
                    FToast().init(context);
                    final fState = fKey.currentState;
                    if (fState!.validate()) {
                      fState.save();
                      context.loaderOverlay.show();
                      final restaurantUser =
                          await FbDbService.getRestaurantByUid(email);
                      if (context.mounted) {
                        if (restaurantUser != null) {
                          final res = await Future.wait([
                            sp.setString(StringConstants.restaurantIdKeyText,
                                restaurantUser.restaurantId ?? ""),
                            FbDbService.updateRestaurantUserDetail(
                                restaurantUser)
                          ]);
                          if (context.mounted) {
                            context.loaderOverlay.hide();
                            Navigator.of(context)
                                .pushNamed(RouteGenerator.homePage);
                          }
                        } else {
                          context.loaderOverlay.hide();
                          MessageService.showErrorMessage(
                              "Restaurant data doesn't exists.Please check the email and try again");
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
