import 'package:amazon_clone/common/widgets/bottombar.dart';
import 'package:amazon_clone/constant/globle_variable.dart';
import 'package:amazon_clone/features/auths/screens/auth_screens.dart';
import 'package:amazon_clone/features/auths/services/auth_services.dart';
import 'package:amazon_clone/porviders/helper.dart';
import 'package:amazon_clone/porviders/user_provider.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => Helper())
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthService authServices = AuthService();
  @override
  void initState() {
    super.initState();
    authServices.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Amazon_clone',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => generateroute(settings),
        theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            colorScheme: const ColorScheme.light(
                primary: GlobalVariables.secondaryColor),
            appBarTheme: const AppBarTheme(
                elevation: 0, iconTheme: IconThemeData(color: Colors.black))),
        home: Provider.of<UserProvider>(context, listen: false)
                .user
                .token
                .isNotEmpty
            ? const Bottombar()
            : const AuthScreen());
  }
}
