import 'package:beco/resources/auth_methods.dart';
import 'package:beco/responsive/mobile_screen_layout.dart';
import 'package:beco/responsive/responsive_layout_screen.dart';
import 'package:beco/responsive/web_screen_layout.dart';
// import 'package:beco/screens/login_screen.dart';
import 'package:beco/utils/colors.dart';
import 'package:beco/utils/utils.dart';
import 'package:beco/widgets/text_field_input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

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

  Uint8List? _image;
  bool _isLoading = false;

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

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image,
    );
    setState(() {
      _isLoading = false;
    });

    if(!mounted) return;
    if (res != "success") {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                  mobileScreen: MobileScreenLayout(),
                  webScreen: WebScreenLayout(),
                )),
      );
    }
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
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "https://wallpapers-clan.com/wp-content/uploads/2022/08/default-pfp-1.jpg"),
                        ),
                  Positioned(
                    bottom: -10,
                    right: -10,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              //button login
              InkWell(
                onTap: signUpUser,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
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
                        child: const Text('Sign Up'),
                      ),
              ),
              const SizedBox(height: 12),
              Flexible(flex: 2, child: Container()),
              //Transitioning to the sign up screen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Already have an account? "),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.pushNamed(context, '/signup');
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) => const LoginScreen(),
                      //   ),
                      // );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Login",
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
