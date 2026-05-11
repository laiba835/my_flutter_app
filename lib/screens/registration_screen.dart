import 'package:flutter/material.dart';
import '../validators/form_validator.dart';
import '../controllers/auth_controller.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  String? _selectedGender;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;
  late AuthController _auth;

  @override
  void initState() {
    super.initState();
    _auth = AuthController();
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      String fullName = '${_firstNameController.text} ${_lastNameController.text}';
      bool success = await _auth.register(
        fullName,
        _emailController.text,
        _passwordController.text,
      );

      if (mounted) {
        setState(() => _isLoading = false);
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful!'), backgroundColor: Colors.green),
          );
          Navigator.pushReplacementNamed(context, '/login');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register'), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.person_add, size: 80, color: Colors.blue),
              const SizedBox(height: 20),
              
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name', border: OutlineInputBorder()),
                validator: (v) => FormValidator.validateRequired(v, 'First name'),
              ),
              const SizedBox(height: 15),
              
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name', border: OutlineInputBorder()),
                validator: (v) => FormValidator.validateRequired(v, 'Last name'),
              ),
              const SizedBox(height: 15),
              
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
                validator: FormValidator.validateEmail,
              ),
              const SizedBox(height: 15),
              
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(labelText: 'Gender', border: OutlineInputBorder()),
                items: ['Male', 'Female', 'Other'].map((g) {
                  return DropdownMenuItem(value: g, child: Text(g));
                }).toList(),
                onChanged: (v) => setState(() => _selectedGender = v),
                validator: (v) => v == null ? 'Select gender' : null,
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
                validator: FormValidator.validatePassword,
              ),
              const SizedBox(height: 15),
              
              TextFormField(
                controller: _confirmController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirm ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ),
                obscureText: _obscureConfirm,
                validator: (v) => FormValidator.validateConfirmPassword(v, _passwordController.text),
              ),
              const SizedBox(height: 25),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Register', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 15),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Have an account? "),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                    child: const Text('Login'),
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }
}