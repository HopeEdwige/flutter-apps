import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 8),
                  child: Image.asset(
                    'assets/images/error.png',
                    scale: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 8),
                  child: Text(
                    "Oh Noo!",
                    style: theme.textTheme.headline3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Looks like you haven't installed WhatsApp yet.",
                    style: theme.textTheme.subtitle1.copyWith(
                      fontSize: 20,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      StoreRedirect.redirect(androidAppId: "com.whatsapp", iOSAppId: "");
                    },
                    child: Text(
                      'Install Now',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
