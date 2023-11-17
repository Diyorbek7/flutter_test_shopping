import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_shopping/src/bloc/home/home_bloc.dart';
import 'package:flutter_test_shopping/src/repository/home/home_repository.dart';
import 'package:flutter_test_shopping/src/ui/main/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: RepositoryProvider(
        create: (context) => HomeRepository(),
        child: BlocProvider(
          create: (context) => HomeBloc(
            repositoryHome: RepositoryProvider.of<HomeRepository>(context),
          ),
          child: const MainScreen(),
        ),
      ),
    );
  }
}
