import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembea/core/commons/Loader.dart';
import 'package:tembea/features/Auth/controllers/auth_controller.dart';
import 'package:tembea/core/widgets/social_signin.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailRegEx = RegExp(
      r"[^a-zA-Z0-9.a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-z]");

  void signupWithEmail(WidgetRef ref) {
    String email = emailController.text;
    String password = passwordController.text;
    ref
        .read(authControllerProvider.notifier)
        .signInWithEmailAndPassword(context, email, password);
  }
  void login(WidgetRef ref){
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }


  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (emailRegEx.hasMatch(value)) {
      return " Enter a valid email";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return isLoading
        ? const Loader()
        : SafeArea(
            child: Scaffold(
              body: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      bottom: 12, top: 0, left: 16, right: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Get Started",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Welcome! Let's create your account.",
                          style: TextStyle(
                              fontSize: 24, color: Colors.grey.shade600),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (val)=>emailValidator(val),
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 0.5)),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 0.5),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                obscureText: true,
                                validator:(val)=> passwordValidator(val),
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                  hintText: "Password",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 0.5)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.5)),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              MaterialButton(
                                color: Colors.green,
                                minWidth: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    signupWithEmail(ref);
                                  }
                                  
                                },
                                child: const Text(
                                  "Sign Up",
                                ),
                              ),
                              MaterialButton(
                                color: Colors.blueAccent,
                                minWidth: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SignupPage()));
                                },
                                child: const Text(
                                  "Login",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        SocialSignin(onClick: ()=>login(ref))
                      ],
                    ),
                  )),
            ),
          );
  }
}
