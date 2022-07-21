import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../wigets/constants.dart';
import '../wigets/tab_button.dart';
import '../wigets/tab_label.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("HELP"),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 25, 78, 109),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.05),
            TabLabel(
              label: 'About ',
              color: kappSecondary,
              align: Alignment.centerLeft,
            ),
            TabButton(
              label: 'FAQs',
              color: kappPrimary,
              icon: Icons.help_outline,
              weight: FontWeight.w400,
              page: () {},
            ),
            Column(
              children: [
                SizedBox(height: size.height * 0.05),
                TabLabel(
                    label: 'Contact Us',
                    color: kappSecondary,
                    align: Alignment.centerLeft),
                const SizedBox(height: 10.0),
                TabButton(
                    label: 'Call Help line',
                    color: kappPrimary,
                    icon: Icons.phone_forwarded_outlined,
                    weight: FontWeight.w400,
                    page: () => {showLoading("Select ")}),
                const Divider(
                    indent: 20.0,
                    endIndent: 25.0,
                    color: kappPrimary,
                    height: 1.0),
                TabButton(
                    label: 'Report a problem',
                    color: kappPrimary,
                    icon: Icons.email_outlined,
                    weight: FontWeight.w400,
                    page: () {
                      final mailtoUri = Uri(
                          scheme: 'mailto',
                          path: 'patrick@gmail.com',
                          queryParameters: {'Report a problem': 'Example'});
                      print(
                          mailtoUri); // mailto:John.Doe@example.com?subject=Example

                      launchUrl(mailtoUri);
                    }),
                const Divider(
                  indent: 20.0,
                  endIndent: 25.0,
                  color: kappPrimary,
                  height: 1.0,
                ),
                TabButton(
                    label: 'Send Feedback',
                    color: kappPrimary,
                    icon: Icons.feedback_outlined,
                    weight: FontWeight.w400,
                    page: () {
                      final mailtoUri = Uri(
                          scheme: 'mailto',
                          path: 'feedback@gmail.com',
                          queryParameters: {'Feedback': 'Example'});
                      print(
                          mailtoUri); // mailto:John.Doe@example.com?subject=Example

                      launchUrl(mailtoUri);
                    }),
                const Divider(
                  indent: 20.0,
                  endIndent: 25.0,
                  color: kappPrimary,
                  height: 1.0,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            TabLabel(
              label: 'App Info',
              color: kappSecondary,
              align: Alignment.centerLeft,
            ),
            const SizedBox(height: 10.0),
            const TabButton(
              label: 'App Version',
              color: kappPrimary,
              weight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(message),
                  TabButton(
                      label: 'MATHEW',
                      color: kappPrimary,
                      icon: Icons.phone_forwarded_outlined,
                      weight: FontWeight.w400,
                      page: () {
                        makePhoneCall("+256779484996");
                      }),
                  TabButton(
                      label: 'PATRICK',
                      color: kappPrimary,
                      icon: Icons.phone_forwarded_outlined,
                      weight: FontWeight.w400,
                      page: () {
                        makePhoneCall("+256703377521");
                      }),
                  TabButton(
                      label: 'NATHAN',
                      color: kappPrimary,
                      icon: Icons.phone_forwarded_outlined,
                      weight: FontWeight.w400,
                      page: () {
                        makePhoneCall("+256775064312");
                      }),
                  TabButton(
                      label: 'EMMANUEL',
                      color: kappPrimary,
                      icon: Icons.phone_forwarded_outlined,
                      weight: FontWeight.w400,
                      page: () {
                        makePhoneCall("+256771352368");
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }
}
