import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/screens/entryPoint/entry_point.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'sign_up_form.dart'; // Import màn hình SignUpForm

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _storage = FlutterSecureStorage();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger error;
  late SMITrigger success;
  late SMITrigger reset;
  late SMITrigger confetti;
  String _errorMessage = '';

  void _onCheckRiveInit(Artboard artboard) {
    StateMachineController? controller =
    StateMachineController.fromArtboard(artboard, 'State Machine 1');

    artboard.addController(controller!);
    error = controller.findInput<bool>('Error') as SMITrigger;
    success = controller.findInput<bool>('Check') as SMITrigger;
    reset = controller.findInput<bool>('Reset') as SMITrigger;
  }

  void _onConfettiRiveInit(Artboard artboard) {
    StateMachineController? controller =
    StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);

    confetti = controller.findInput<bool>("Trigger explosion") as SMITrigger;
  }

  Future<void> signIn(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isShowLoading = true;
        isShowConfetti = false;
        _errorMessage = '';
      });

      try {
        final response = await http.post(
          Uri.parse('http://localhost:3000/api/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': _emailController.text.trim(),
            'password': _passwordController.text.trim(),
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          await _storage.write(key: 'jwt_token', value: data['token']);
          success.fire();
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              isShowLoading = false;
              isShowConfetti = true;
            });
            confetti.fire();
            Future.delayed(const Duration(seconds: 1), () {
              if (!context.mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const EntryPoint(),
                ),
              );
            });
          });
        } else {
          setState(() {
            _errorMessage = 'Invalid credentials';
          });
          error.fire();
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              isShowLoading = false;
            });
            reset.fire();
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Error: $e';
        });
        error.fire();
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });
          reset.fire();
        });
      }
    } else {
      error.fire();
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isShowLoading = false;
        });
        reset.fire();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Email",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset("assets/icons/email.svg"),
                    ),
                  ),
                ),
              ),
              const Text(
                "Password",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset("assets/icons/password.svg"),
                    ),
                  ),
                ),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: ElevatedButton.icon(
                  onPressed: () {
                    signIn(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF77D8E),
                    minimumSize: const Size(double.infinity, 56),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                    ),
                  ),
                  icon: const Icon(
                    CupertinoIcons.arrow_right,
                    color: Color(0xFFFE0037),
                  ),
                  label: const Text("Sign In"),
                ),
              ),
              const Center(
                child: Text(
                  "OR",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nút Email (điều hướng đến SignUpForm)
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpForm(),
                        ),
                      );
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/email.svg",
                      height: 24,
                      width: 24,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(
                        side: BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Nút Apple (chưa xử lý)
                  IconButton(
                    onPressed: () {
                      // TODO: Xử lý đăng ký/đăng nhập bằng Apple
                    },
                    icon: const Icon(
                      Icons.apple,
                      size: 24,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(
                        side: BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Nút Google (chưa xử lý)
                  IconButton(
                    onPressed: () {
                      // TODO: Xử lý đăng ký/đăng nhập bằng Google
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/google.svg", // Đảm bảo bạn có file google.svg
                      height: 24,
                      width: 24,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(
                        side: BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  "Sign up with Email, Apple or Google",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
        isShowLoading
            ? CustomPositioned(
          child: RiveAnimation.asset(
            'assets/RiveAssets/check.riv',
            fit: BoxFit.cover,
            onInit: _onCheckRiveInit,
          ),
        )
            : const SizedBox(),
        isShowConfetti
            ? CustomPositioned(
          scale: 6,
          child: RiveAnimation.asset(
            "assets/RiveAssets/confetti.riv",
            onInit: _onConfettiRiveInit,
            fit: BoxFit.cover,
          ),
        )
            : const SizedBox(),
      ],
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, this.scale = 1, required this.child});

  final double scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 100,
            width: 100,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}