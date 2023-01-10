import 'package:beco/utils/colors.dart';
import 'package:beco/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // TextEditingController는 텍스트 필드의 내용을 제어하는 데 사용
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    // dispose()는 위젯이 제거될 때 호출되는 메서드
    super.dispose();
    // controller를 제거
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // 안전 영역 ( 상태바, 하단바 )
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 20), // container padding
          width: double.infinity, // 가로 길이를 최대로
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //svg image
              SvgPicture.asset(
                "assets/ic_instagram.svg",
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 60),
              //text field for username
              TextFieldInput(
                hintText: "Enter your username",
                inputType: TextInputType.text,
                controller: _usernameController,
              ),
              const SizedBox(height: 20),
              //text field for email
              TextFieldInput(
                hintText: "Enter your email",
                inputType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              //text field for password
              TextFieldInput(
                hintText: "Enter your password",
                inputType: TextInputType.text,
                controller: _passwordController,
                isPass: true,
              ),
              const SizedBox(height: 20),
              //text field for bio
              TextFieldInput(
                hintText: "Enter your bio",
                inputType: TextInputType.text,
                controller: _bioController,
              ),
              const SizedBox(height:20),
              //button login
              InkWell(
                child: Container(
                  child: const Text('Log in'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(child: Container(), flex: 2),
              //Transitioning to the sign up screen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Container(
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
