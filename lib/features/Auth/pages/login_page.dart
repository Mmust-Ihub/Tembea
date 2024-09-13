import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tembea/core/commons/Loader.dart';
import 'package:tembea/features/Auth/controllers/auth_controller.dart';
import 'package:tembea/features/Auth/pages/signup_page.dart';
import 'package:tembea/core/widgets/social_signin.dart';
 
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  GlobalKey<FormState> loginformkey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void loginWithEmail(WidgetRef ref) {
    String email = emailController.text;
    String password = passwordController.text;
    ref
        .read(authControllerProvider.notifier)
        .signUpWithEmailAndPassword(context, email, password);
  }

  void login(WidgetRef ref,BuildContext c){
    ref.read(authControllerProvider.notifier).signInWithGoogle(c);
  } 
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    return null;
  }String? emailValidator(String? value) {
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
    final r = ref;
    return isLoading
        ? const Scaffold(body: Loader(),)
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
                          "Time for the adventure.",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Welcome! Let's get you into your account.",
                          style: TextStyle(
                              fontSize: 24, color: Colors.grey.shade600),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Form(
                          key: loginformkey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (val)=>emailValidator(val),
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.mail_outline,
                                    ),
                                    hintText: "Email",
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 0.5)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0.5))),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                obscureText: true,
                                controller: passwordController,
                                validator: (val)=>passwordValidator(val),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.key_outlined),
                                  contentPadding: EdgeInsets.all(8),
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0.5)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 0.5)),
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
                                  if (loginformkey.currentState!.validate()) {
                                    loginWithEmail(r);
                                  }                                  
                                  
                                },
                                child: const Text(
                                  "Login",
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
                                          builder: (context) => SignupPage()));
                                },
                                child: const Text(
                                  "SignUp",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        SocialSignin(onClick: ()=>login(ref,context)),
                      ],
                    ),
                  )),
            ),
          );
  }
}
