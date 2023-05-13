import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_users_generator/cubit/users_cubit.dart';
import 'package:random_users_generator/repositories/dio/dio_settings.dart';
import 'package:random_users_generator/repositories/users_repository.dart';

import 'screens/users_screen/users_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DioSettings(),
        ),
        RepositoryProvider(
          create: (context) => UsersRepository(
            dio: RepositoryProvider.of<DioSettings>(context).dio,
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => UsersCubit(
          usersRepository: RepositoryProvider.of<UsersRepository>(context),
        )..getUsers(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Users Generator',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.grey[300],
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              bodyMedium: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
            ),
          ),
          home: const UsersScreen(),
        ),
      ),
    );
  }
}
