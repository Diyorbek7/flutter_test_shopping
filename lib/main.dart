import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test_shopping/src/bloc/home/home_bloc.dart';
import 'package:flutter_test_shopping/src/repository/home/home_repository.dart';
import 'package:flutter_test_shopping/src/service/cache_service.dart';
import 'package:flutter_test_shopping/src/ui/home/home_screen.dart';
import 'package:flutter_test_shopping/src/ui/main/main_screen.dart';
import 'package:flutter_translate/flutter_translate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheService.init();

  var delegate = await LocalizationDelegate.create(
    fallbackLocale: CacheService.getLanguage(),
    supportedLocales: ['uz', 'en', 'ru'],
  );
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then(
        (_) => runApp(
      LocalizedApp(
        delegate,
        const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalizationDelegate localizationDelegate =
        LocalizedApp.of(context).delegate;
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: Locale(CacheService.getLanguage()),
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
      ),
    );
  }
}
