import 'package:flutter/material.dart';
import 'package:test_be_talent/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BeTalent',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: MyStyles.primary),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            // H1
            titleLarge: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            // H2
            titleMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            // H3
            titleSmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          )),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 68,
        leading: Transform.translate(
          offset: const Offset(20, 0),
          child: const CircleAvatar(
            radius: 106.38,
            backgroundColor: MyStyles.gray05,
            child: Text('MV'),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_rounded)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Text('Funcionários', style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}
