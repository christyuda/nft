import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/common/provider/general_provider.dart';
import 'package:webordernft/config/palette.dart';

import '../../../config/constant.dart';
import '../provider/login_provider.dart';

class LoginMom extends StatefulWidget {
  const LoginMom({Key? key}) : super(key: key);

  @override
  State<LoginMom> createState() => _LoginMomState();
}

class _LoginMomState extends State<LoginMom> {
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgcolor,
      body: Center(
        child: Container(
          width: 900, // Increased width for better visibility
          height: 550, // Increased height for more space
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Row(
            children: [
              // Left image section
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/banner/teamwork.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        'assets/images/logo/logo_company.png',
                        width: 120, // Slightly larger logo
                        height: 60,
                      ),
                    ),
                  ),
                ),
              ),
              // Right form section
              Expanded(
                flex: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
                  child: LoginForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final _key = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginProvider>(context, listen: false);
    return FormBuilder(
      key: _key,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang,',
              style: TextStyle(
                fontSize: 26, // Increased font size
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'di POS FINANSIAL INDONESIA - Backoffice',
              style: TextStyle(fontSize: 20, color: Colors.black54),
            ),
            SizedBox(height: 8),
            Text(
              'Silahkan login untuk dapat mengakses menu',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 28),
            FormBuilderTextField(
              name: 'email',
              onSaved: (val) => login.pinemail = val!,
              validator: FormBuilderValidators.required(
                  errorText: "Email Tidak Boleh Kosong"),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                    color: Palette.blackClr,
                    fontSize: 16), // Increased font size
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Palette.bordercolor, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Palette.primary, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            FormBuilderTextField(
              name: 'password',
              validator: FormBuilderValidators.required(
                  errorText: "Password belum diisi"),
              onSaved: (val) => login.pinpassword = val!,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                    color: Palette.blackClr,
                    fontSize: 16), // Increased font size
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: Palette.bordercolor, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Palette.primary, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.saveAndValidate()) {
                    Provider.of<GeneralProv>(context, listen: false)
                        .isLoading();
                    login.submitlogin(context);
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.primary,
                  padding: EdgeInsets.symmetric(
                      vertical: 18), // Larger button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
