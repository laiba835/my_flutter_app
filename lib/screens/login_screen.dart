import 'package:flutter/material.dart';
import '../validators/form_validator.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;
  late AuthController _auth;

  @override
  void initState() {
    super.initState();
    _auth = AuthController();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      _auth.setRememberMe(_rememberMe);
      
      bool success = await _auth.login(_emailController.text, _passwordController.text);
      
      if (mounted) {
        setState(() => _isLoading = false);
        if (success) {
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Failed'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, size: 80, color: Colors.blue),
              const SizedBox(height: 20),
              const Text('Welcome Back', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                      keyboardType: TextInputType.emailAddress,
                      validator: FormValidator.validateEmail,
                    ),
                    const SizedBox(height: 15),
                    
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      obscureText: _obscurePassword,
                      validator: (v) => FormValidator.validateRequired(v, 'Password'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (v) => setState(() => _rememberMe = v ?? false),
                  ),
                  const Text('Remember Me'),
                  const Spacer(),
                  TextButton(onPressed: () {}, child: const Text('Forgot Password?')),
                ],
              ),
              const SizedBox(height: 20),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Login', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 15),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No account? "),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                    child: const Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}