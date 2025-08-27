import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/authentication/controller/auth_state.dart';
import 'package:zcmc_portal/src/authentication/providers/auth_providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _employeeIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _hasSetUpListener = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    
    // ✅ CORRECT: Set up listener during build phase
    if (!_hasSetUpListener) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _hasSetUpListener = true;
          });
        }
      });
    }

    if(_hasSetUpListener){
      ref.listen<AuthState>(authStateProvider, (previous, next) {
        if (next is AuthStateAuthenticated && mounted) {
          Navigator.of(context).pushReplacementNamed('/dashboard');
        }
      });
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://zcmc.online/zcmc.png",
                    height: 100,
                  ),
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _employeeIdController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Employee ID",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: "Password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscurePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Handle forgot password
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: MaterialButton(
                              color: Colors.blue,
                              onPressed: _handleLogin,
                              child: authState is AuthStateLoading
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(Colors.white),
                                    )
                                  : const Text(
                                      "Login",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                          // Error message display
                          if (authState is AuthStateError)
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                authState.message,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      final username = _employeeIdController.text;
      final password = _passwordController.text;

      final authController = ref.read(authControllerProvider);
      await authController.login(username, password);
    }
  }

  @override
  void dispose() {
    _employeeIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}