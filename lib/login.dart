import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final result = ref.read(loginProvider.notifier).login(
                      email: emailController.text,
                      password: passwordController.text,
                    );
              },
              child: const Text('Login'),
            ),
            if (loginState is LoginLoading) ...[
              const SizedBox(height: 16),
              const CircularProgressIndicator(),
            ],
            if (loginState is LoginError) ...[
              const SizedBox(height: 16),
              Text(
                loginState.error,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    try {
      state = LoginLoading();
      await Future.delayed(const Duration(seconds: 2));
      if (email == 'user@example.com' && password == 'password') {
        state = LoginSuccess();
      } else {
        state = LoginError('Invalid email or password');
      }
    } catch (e) {
      state = LoginError('An error occurred');
    }
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}
