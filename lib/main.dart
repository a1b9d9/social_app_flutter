import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modulse/log_in/log_in_screen.dart';
import 'package:social_app/shared/components/block_observer.dart';
import 'package:social_app/shared/network/local/shared_preferences.dart';
import 'package:social_app/shared/style/colors.dart';

import 'layout/cubit/cubit.dart';
import 'layout/social_home_screen.dart';
import 'modulse/log_in/cubit/cubit.dart';
import 'modulse/log_in/cubit/states.dart';
import 'modulse/register/cubit/cubit.dart';
import 'shared/style/them_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget startScreen;
  if (CacheHelper.getData(key: "uid") != null) {
    startScreen = const SocialHome();
  } else {
    startScreen = const Login();
  }

  runApp(MyApp(
    screen: startScreen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget screen;

  const MyApp({Key? key, required this.screen}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SocialLoginCubit(),
          ),
          BlocProvider(
            create: (context) => SocialHomeCubit()..getDataUser()..getPost()..getUsers(),
          ),
          BlocProvider(
            create: (context) => SocialRegisterCubit(),
          ),
        ],
        child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                  home: screen,
                  debugShowCheckedModeBanner: false,
                  theme:light);
            }));
  }
}

