import 'package:flutter/material.dart';
import 'package:pdf_generator/pdf_from_url.dart';
import 'package:pdf_generator/pdf_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async => await saveAndLaunchPrescriptionPDF(),
                child: const Text("Create PDF and Launch")),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ViewerPDF(
                        url:
                            "http://13.203.127.220:8080/api/pdf/1732955279653-58200040-prescription (3).pdf",
                      ),
                    )),
                child: const Text("Launch PDF from URL")),
          ],
        ),
      ),
    );
  }
}
