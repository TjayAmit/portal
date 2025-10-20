import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/authentication/providers/auth_providers.dart';

class LoginWithPin extends ConsumerStatefulWidget {
  const LoginWithPin({super.key});

  @override
  ConsumerState<LoginWithPin> createState() => _LoginWithPinState();
} 

class _LoginWithPinState extends ConsumerState<LoginWithPin> {
  final TextEditingController _pinController = TextEditingController();
  bool _isError = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Authorization PIN')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 6,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: '6-digit PIN',
                errorText: _isError ? 'Invalid PIN' : null,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyPin,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyPin() async {
    final authController = ref.read(authControllerProvider);

    if (await authController.verifyAuthorizationPin(_pinController.text)) {
      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/dashboard');
      return;
    }

    setState(() {
      _isError = true;
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }
}
