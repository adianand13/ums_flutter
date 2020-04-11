import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ums_flutter/bloc/authentication_bloc.dart';
import 'package:ums_flutter/event_state/authentication/authentication_event.dart';
import 'package:ums_flutter/services/auth_service.dart';
import 'package:ums_flutter/services/user_service.dart';
import 'app.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main(){
  //ensure only portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final authService = AuthService();
  final userService = UserService();
  runApp(
      BlocProvider<AuthenticationBloc>(
          create: (context) {
            return AuthenticationBloc(authService: authService)
              ..add(AppStarted());
          },
          child: MyApp(authService: authService, userService: userService,)
      )
  );
}

//Future<void> printData () async {
//  FlutterSecureStorage storage = FlutterSecureStorage();
//  UserApiProvider provider = UserApiProvider();
//  String token = await storage.read(key: "token");
//  var userJson = await provider.getUser("", token);
//  var headers = {
//    "Content-Type": "application/json",
//    "Authorization": 'Bearer $token'
//  };
//
//
//  var response = await http.get("http://localhost:8080/api/user/", headers: headers);
//  print(token);
//  var user = UserModel.fromJsonMap(json.decode(response.body)['data']);
//  print(user.username);
//  print(json.decode(response.body));
//}