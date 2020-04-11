import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/authentication_bloc.dart';
import 'package:ums_flutter/event_state/authentication/authentication_state.dart';
import 'package:ums_flutter/screens/login_screen/login_screen.dart';
import 'package:ums_flutter/screens/sidebar_screen/sidebar_layout.dart';
import 'package:ums_flutter/screens/splash_screen.dart';

import 'package:ums_flutter/services/auth_service.dart';
import 'package:ums_flutter/services/user_service.dart';
import 'package:ums_flutter/utils/theme.dart';

class MyApp extends StatelessWidget {
  final AuthService authService;
  final UserService userService;

  MyApp({Key key, @required this.authService, @required this.userService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UMS',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
//            themeMode: themeState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return SideBarLayout(
              authService: authService,
              userService: userService,
            );
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginScreen(
              authService: authService,
              userService: userService,
            );
          }
          if (state is AuthenticationLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SplashPage();
        },
      ),
    );
  }
}
