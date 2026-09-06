import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/button/button_cubit.dart';
import 'package:real_estate/core/helper_function/shared_prefs.dart';
import 'package:real_estate/features/splash/splash_page.dart';
import 'package:real_estate/service_locator.dart';

void main() async{
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ButtonCubit>(create: (_) => ButtonCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home:  SplashPage(),
      ),
    );
  }
}
