import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_be_talent/api/repositories/employee_repository.dart';
import 'package:test_be_talent/api/stores/employee_store.dart';
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
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: MyStyles.gray05,
            iconColor: MyStyles.black,
            outlineBorder: BorderSide(color: MyStyles.gray05),
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(color: MyStyles.primary)),
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
  TextEditingController employeeSearchController = TextEditingController();
  EmployeeStore employeeStore = EmployeeStore(repository: EmployeeRepository());
  List<bool> isExpanded = [];
  @override
  void initState() {
    employeeStore.index().whenComplete(() => isExpanded = List.filled(employeeStore.state.value.length, false));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget panelContent(BuildContext context, String content, String leadingText) => DecoratedBox(
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: MyStyles.gray05))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(leadingText, style: Theme.of(context).textTheme.titleMedium),
            Text(content),
          ],
        ),
      );

  String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 13) {
      final countryCode = phoneNumber.substring(0, 2);
      final ddd = phoneNumber.substring(2, 4);
      final prefix = phoneNumber.substring(4, 9);
      final suffix = phoneNumber.substring(9);

      return '+$countryCode ($ddd) $prefix-$suffix';
    } else {
      return 'Número inválido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text('Funcionários', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 15),
              TextField(
                decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Pesquisar'),
                controller: employeeSearchController,
              ),
              const SizedBox(height: 24),
              AnimatedBuilder(
                animation: Listenable.merge([employeeStore.isLoading, employeeStore.state, employeeStore.erro]),
                builder: (context, child) {
                  if (employeeStore.isLoading.value) {
                    return const Center(child: CircularProgressIndicator.adaptive());
                  }
                  if (employeeStore.erro.value.isNotEmpty) {
                    return Text('Nenhum funcionário encontrado.', style: Theme.of(context).textTheme.titleSmall);
                  }
                  return Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(color: MyStyles.blue10, borderRadius: BorderRadius.vertical(top: Radius.circular(14))),
                        child: LayoutBuilder(
                          builder: (context, constraints) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14.5, vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: constraints.maxWidth * (30 / 100) - 10, child: const Text('Foto')),
                                    SizedBox(width: constraints.maxWidth * (55 / 100) - 10, child: const Text('Nome')),
                                  ],
                                ),
                                SizedBox(width: constraints.maxWidth * (15 / 100) - 9, child: const Icon(Icons.circle, size: 8)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ExpansionPanelList(
                        elevation: 1,
                        dividerColor: MyStyles.gray10,
                        expandIconColor: MyStyles.primary,
                        animationDuration: const Duration(milliseconds: 300),
                        expansionCallback: (index, isExpanded) {
                          setState(() {
                            this.isExpanded[index] = isExpanded;
                          });
                        },
                        children: employeeStore.state.value.asMap().entries.map((entry) {
                          final employee = entry.value;
                          final index = entry.key;
                          var dateFormatter = DateFormat('dd/MM/yyyy');
                          var formattedAdmissionDate = dateFormatter.format(employee.admissionDate);
                          return ExpansionPanel(
                            splashColor: MyStyles.blue10,
                            isExpanded: isExpanded[index],
                            canTapOnHeader: true,
                            backgroundColor: Colors.white,
                            headerBuilder: (context, isExpanded) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 13.5, bottom: 12.5),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 16),
                                    CircleAvatar(backgroundImage: NetworkImage(employee.urlImage), radius: 34),
                                    const SizedBox(width: 24),
                                    Flexible(
                                      child: Text(
                                        employee.name,
                                        style: Theme.of(context).textTheme.titleSmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            body: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 31),
                              child: Column(
                                children: [
                                  panelContent(context, employee.job, "Cargo"),
                                  panelContent(context, formattedAdmissionDate, "Data de admissão"),
                                  panelContent(context, formatPhoneNumber(employee.phone), "Telefone"),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 70),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
