import 'package:flutter/material.dart';

import 'main_view.dart';

class PcDiagnosisApp extends StatelessWidget {
  const PcDiagnosisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aima client',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const WelcomeView(),
    );
  }
}

class WelcomeView extends StatelessWidget {
  const WelcomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 100,
              ),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  const Text('Welcome to the Pc Diagnostics App',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 20),
                  const Text(
                      'Click the button below to start diagnosing your PC',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainView()));
                    },
                    child: const Text('Start Diagnosis'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
