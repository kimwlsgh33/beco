import 'package:beco/resources/auth_methods.dart';
import 'package:beco/responsive/mobile_screen_layout.dart';
import 'package:beco/responsive/responsive_layout_screen.dart';
import 'package:beco/responsive/web_screen_layout.dart';
import 'package:beco/screens/signup_screen.dart';
import 'package:beco/utils/colors.dart';
import 'package:beco/utils/global_variables.dart';
import 'package:beco/utils/utils.dart';
import 'package:beco/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController는 텍스트 필드의 내용을 제어하는 데 사용
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethod().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    // mounted는 위젯이 현재 트리에 있는지 확인
    if (!mounted) return;

    if (res == "success") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                  mobileScreen: MobileScreenLayout(),
                  webScreen: WebScreenLayout(),
                )),
      );
    } else {
      showSnackBar(context, res);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // 안전 영역 ( 상태바, 하단바 )
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity, // 가로 길이를 최대로
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              //svg image
              SvgPicture.asset(
                "assets/ic_instagram.svg",
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 60),
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
              //button login
              InkWell(
                onTap: loginUser,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          color: blueColor,
                        ),
                        child: const Text('Log in'),
                      ),
              ),
              const SizedBox(height: 12),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              //Transitioning to the sign up screen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Don't have an account? "),
                  ),
                  GestureDetector(
                    onTap: () {
                      // pushReplacement: 현재 화면을 제거하고 새로운 화면으로 이동
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) => const SignupScreen(),
                      //   ),
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
