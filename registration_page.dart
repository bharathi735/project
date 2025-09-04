import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';
import 'firestore.dart'; // Import Firestore interaction functions

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});
  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Expanded(
              //  child: Image.asset(
              //  "assets/staffs/images.png",
              //  width: 60,
              //  height: 60,
              //   ),
              //  ),
              Text(
                "Mother Teresa Women's University",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E40AF),
                ),
                textAlign: TextAlign.center,
              ),
              // const SizedBox(height: 4),
              // Expanded(
              //   child: Image.asset(
              //    "assets/staffs/logo.png",
              //  ),
              // ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "Department of Computer Science",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 100,
            ),
            buildHeader(),
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Create an Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E40AF),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Fill in the details to get started',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            const RegistrationForm(),
          ],
        ),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool userExists = false;
  final RegExp regExp = RegExp(
      // r'^(20 23BC([01-9]|[1-3][0-9]|45))|(2024BC([01-9]|[1-3][0-9]|45))|(2022BC([01-9]|[1-3][0-9]|45))$',
      r'^(2022BC0[1-9]|2022BC[1-3][0-9]|2022BC4[0-5]|2023BC0[0-9]|2023BC[1-3][0-9]|2023BC4[0-5]|2024BC0[0-9]|2024BC[1-3][0-9]|2024BC4[0-5])$');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Full Name',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Colors.blue), // Adjust if needed
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Full name cannot be empty";
              } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                return "Enter a valid name";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              hintText: 'Register Number',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: Colors.blue), // Change color if needed
              ),
            ),
            // onFieldSubmitted: (text) {
            //   if (regExp.hasMatch(phoneController.text)) {
            //     return ""; // Consider handling validation properly
            //   }
            // },
            onChanged: (text) async {
              await getUser(phoneController.text).then((data) {
                setState(() => userExists = data != null);
              });
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Field cannot be empty";
              } else if (!regExp.hasMatch(value)) {
                return "Invalid Register Number";
              } else if (userExists) {
                return 'User with this register number already exists';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: 'Password',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Colors.blue), // Change if needed
              ),
            ),
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (phoneController.text != value || !regExp.hasMatch(value!)) {
                return "Invalid password";
              }
              if (value.isEmpty) {
                return "Password cannot be empty";
              } else if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          CupertinoButton.filled(
            borderRadius: BorderRadius.circular(12),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                addUser(nameController.text, phoneController.text,
                    passwordController.text);
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(builder: (context) => const LoginPage()),
                );
              }
            },
            child: const Text('Register', style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 20),
          Center(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                text: 'Returning user? Login ',
                children: [
                  TextSpan(
                    text: 'here',
                    style: const TextStyle(
                      color: Color(0xFF1E40AF),
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
