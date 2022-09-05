import 'package:dating_app/api/config/config.dart';
import 'package:dating_app/api/providers.dart';
import 'package:dating_app/dialogs/progress_dialog.dart';
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/screens/home_screen.dart';
import 'package:dating_app/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/constants.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  // Variables
  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  String? _phoneCode = '+1'; // Define yor default phone code
  final String _initialSelection = 'US'; // Define yor default country code
  late AppLocalizations _i18n;
  late ProgressDialog _pr;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Initialization
    _i18n = AppLocalizations.of(context);
    _pr = ProgressDialog(context, isDismissible: false);

    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: APP_PRIMARY_COLOR,
          leading: IconButton(
              onPressed: () => (Navigator.pop(context)),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(_i18n.translate("sign_in"),
              style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // CircleAvatar(
              //   radius: 50,
              //   backgroundColor: Theme.of(context).primaryColor,
              //   child: const SvgIcon("assets/icons/call_icon.svg",
              //       width: 60, height: 60, color: Colors.white),
              // ),
              // const SizedBox(height: 10),
              // Text(_i18n.translate("sign_up"),
              //     textAlign: TextAlign.center,
              //     style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 25),
              // Text(
              //     _i18n.translate(
              //         "please_enter_your_phone_number_and_we_will_send_you_a_sms"),
              //     textAlign: TextAlign.center,
              //     style: const TextStyle(fontSize: 18, color: Colors.grey)),
              // const SizedBox(height: 22),

              /// Form
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        controller: _username,
                        decoration: InputDecoration(
                          labelText: _i18n.translate("username"),
                          hintText: _i18n.translate("enter_your_username"),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          // prefixIcon: Padding(
                          //   padding: const EdgeInsets.only(left: 8.0),
                          //   child: CountryCodePicker(
                          //       alignLeft: false,
                          //       initialSelection: _initialSelection,
                          //       onChanged: (country) {
                          //         /// Get country code
                          //         _phoneCode = country.dialCode!;
                          //       }),
                          // )),
                          // keyboardType: TextInputType.number,
                          // inputFormatters: <TextInputFormatter>[
                          //   FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                          // ],
                          // validator: (number) {
                          //   // Basic validation
                          //   if (number.toString().isEmpty) {
                          //     return _i18n
                          //         .translate("please_enter_your_phone_number");
                          //   }
                          //   return null;
                          // },
                        )),
                    SizedBox(height: 10),
                    TextFormField(
                        controller: _password,
                        decoration: InputDecoration(
                          labelText: _i18n.translate("password"),
                          hintText: _i18n.translate("enter_your_password"),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        )),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.maxFinite,
                      child: DefaultButton(
                        child: Text(_i18n.translate("CONTINUE"),
                            style: const TextStyle(fontSize: 18)),
                        onPressed: () async {
                          /// Validate form
                          // if (_formKey.currentState!.validate()) {
                          await context
                              .read(authprovider)
                              .sign_in(_username.text, _password.text, context);

                          /// Sign in
                          // await context.read(authprovider).sign_up(
                          //     _username.text, _email.text, _password.text);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => HomeScreen())
                          //         );
                          // _signIn(context);
                          // }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  /// Navigate to next page
  // void _nextScreen(screen) {
  //   // Go to next page route
  //   Future(() {
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (context) => screen), (route) => false);
  //   });
  // }

  // /// Sign in with phone number
  // void _signIn(BuildContext context) async {
  //   // Show progress dialog
  //   _pr.show(_i18n.translate("processing"));

  //   /// Verify user phone number
  //   await UserModel().verifyPhoneNumber(
  //       phoneNumber: _phoneCode! + _numberController.text.trim(),
  //       checkUserAccount: () {
  //         /// Authenticate User Account
  //         UserModel().authUserAccount(
  //             updateLocationScreen: () =>
  //                 _nextScreen(const UpdateLocationScreen()),
  //             signUpScreen: () => _nextScreen(const SignUpScreen()),
  //             homeScreen: () => _nextScreen(const HomeScreen()),
  //             blockedScreen: () => _nextScreen(const BlockedAccountScreen()));
  //         // END
  //       },
  //       codeSent: (code) async {
  //         // Hide progreess dialog
  //         _pr.hide();
  //         // Go to verification code screen
  //         Navigator.of(context).push(MaterialPageRoute(
  //             builder: (context) => VerificationCodeScreen(
  //                   verificationId: code,
  //                 )));
  //       },
  //       onError: (errorType) async {
  //         // Hide progreess dialog
  //         _pr.hide();

  //         // Check Erro type
  //         if (errorType == 'invalid_number') {
  //           // Check error type
  //           final String message =
  //               _i18n.translate("we_were_unable_to_verify_your_number");
  //           // Show error message
  //           // Validate context
  //           if (mounted) {
  //             showScaffoldMessage(
  //                 context: context, message: message, bgcolor: Colors.red);
  //           }
  //         }
  //       });
  // }

}
