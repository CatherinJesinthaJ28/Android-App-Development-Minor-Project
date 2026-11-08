import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// ==================== HOME PAGE ====================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Application',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.apps,
                size: 80,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 20),

              const Text(
                'WELCOME',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Choose an application',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),

              const SizedBox(height: 40),

              // Calculator Button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculatorPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.calculate),
                  label: const Text(
                    'Calculator',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Registration Button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.app_registration),
                  label: const Text(
                    'Registration Form',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              const Text(
                'Developed by',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'CATHERIN JESINTHA J',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                'B.Sc COMPUTER SCIENCE',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                "ST. ANNE'S ARTS AND SCIENCE COLLEGE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== CALCULATOR ====================

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = '0';

  double? firstNumber;
  String? operator;

  void numberPressed(String number) {
    setState(() {
      if (display == '0') {
        display = number;
      } else {
        display += number;
      }
    });
  }

  void decimalPressed() {
    setState(() {
      if (!display.contains('.')) {
        display += '.';
      }
    });
  }

  void operatorPressed(String selectedOperator) {
    setState(() {
      firstNumber = double.tryParse(display);
      operator = selectedOperator;
      display = '0';
    });
  }

  void calculate() {
    if (firstNumber == null || operator == null) {
      return;
    }

    final secondNumber = double.tryParse(display);

    if (secondNumber == null) {
      return;
    }

    double result = 0;

    switch (operator) {
      case '+':
        result = firstNumber! + secondNumber;
        break;

      case '-':
        result = firstNumber! - secondNumber;
        break;

      case '×':
        result = firstNumber! * secondNumber;
        break;

      case '÷':
        if (secondNumber == 0) {
          setState(() {
            display = 'Cannot divide by 0';
            firstNumber = null;
            operator = null;
          });
          return;
        }
        result = firstNumber! / secondNumber;
        break;
    }

    setState(() {
      if (result == result.toInt()) {
        display = result.toInt().toString();
      } else {
        display = result.toString();
      }

      firstNumber = null;
      operator = null;
    });
  }

  void clearCalculator() {
    setState(() {
      display = '0';
      firstNumber = null;
      operator = null;
    });
  }

  Widget calculatorButton(
    String text, {
    VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepPurple.shade50,
                ),
                child: FittedBox(
                  child: Text(
                    display,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: calculatorButton(
                            '7',
                            onPressed: () => numberPressed('7'),
                          ),
                        ),
                        Expanded(
                          child: calculatorButton(
                            '8',
                            onPressed: () => numberPressed('8'),
                          ),
                        ),
                        Expanded(
                          child: calculatorButton(
                            '9',
                            onPressed: () => numberPressed('9'),
                          ),
                        ),
                        Expanded(
                          child: calculatorButton(
                            '÷',
                            onPressed: () => operatorPressed('÷'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: calculatorButton(
                            '4',
                            onPressed: () => numberPressed('4'),
                          ),
                        ),
                        Expanded(
                          child: calculatorButton(
                            '5',
                            onPressed: () => numberPressed('5'),
                          ),
                        ),
                        Expanded(
                          child: calculatorButton(
                            '6',
                            onPressed: () => numberPressed('6'),
                          ),
                        ),
                        Expanded(
                          child: calculatorButton(
                            '×',
                            onPressed: () => operatorPressed('×'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: calculatorButton(
                            '1',
                            onPressed: () => numberPressed('1'),
                          ),
                        ),
                        Expanded(
                          child: calculatorButton(
                            '2',
                            onPressed: () => numberPressed('2'),
                          ),
                        ),
                        Expanded(
                          child: calculatorButton(
                            '3',
                            onPressed: () => numberPressed('3'),
                          ),
                        ),
                        Expanded(
                          child: calculatorButton(
                            '-',
                            onPressed: () => operatorPressed('-'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: calculatorButton(
                            'C',
                            onPressed: clearCalculator,
                          ),
                        ),
                        Expanded(
                          child: calculatorButton(
                            '0',
                            onPressed: () => numberPressed('0'),
                          ),
                        ),
                        Expanded(
                          child: calculatorButton(
                            '.',
                            onPressed: decimalPressed,
                          ),
                        ),
                        Expanded(
                          child: calculatorButton(
                            '+',
                            onPressed: () => operatorPressed('+'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: calculatorButton(
                            '=',
                            onPressed: calculate,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'CATHERIN JESINTHA J • B.Sc COMPUTER SCIENCE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== REGISTRATION FORM ====================

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  String gender = 'Select Gender';

  bool obscurePassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void register() {
    if (formKey.currentState!.validate() &&
        gender != 'Select Gender') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Registration completed successfully!',
          ),
        ),
      );
    } else if (gender == 'Select Gender') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your gender.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registration Form',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade50,
              Colors.white,
            ],
          ),
        ),

        child: Form(
          key: formKey,

          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              children: [
                const Icon(
                  Icons.person_add_alt_1,
                  size: 75,
                  color: Colors.deepPurple,
                ),

                const SizedBox(height: 10),

                const Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                // Name
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Email
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    if (!value.contains('@')) {
                      return 'Enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Phone
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                // Gender
                DropdownButtonFormField<String>(
                  value: gender,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    prefixIcon: Icon(Icons.people),
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Select Gender',
                      child: Text('Select Gender'),
                    ),
                    DropdownMenuItem(
                      value: 'Female',
                      child: Text('Female'),
                    ),
                    DropdownMenuItem(
                      value: 'Male',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: 'Other',
                      child: Text('Other'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),

                const SizedBox(height: 15),

                // Password
                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must contain at least 6 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 25),

                // Register button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: register,
                    icon: const Icon(Icons.check_circle),
                    label: const Text(
                      'REGISTER',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  'CATHERIN JESINTHA J',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Text(
                  'B.Sc COMPUTER SCIENCE',
                ),

                const Text(
                  "ST. ANNE'S ARTS AND SCIENCE COLLEGE",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}