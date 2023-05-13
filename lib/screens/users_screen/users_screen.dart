import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_users_generator/cubit/users_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../widgets/refresh_button.dart';
import '../widgets/users_avatar.dart';
import '../widgets/users_icons_button.dart';
import '../widgets/users_text_button.dart';
import '../widgets/userts_text_info.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final currentIndex = ValueNotifier<int>(1);

  @override
  void dispose() {
    currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersCubit, UsersStates>(
        builder: (context, state) {
          final users = state.model.results?[0];
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(25),
            children: [
              const SizedBox(height: 35),
              const UsersAvatar(),
              const SizedBox(height: 24),
              const UsersTextInfo(),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: UsersIconsButton(
                      icon: const Icon(Icons.add),
                      onPress: () async {
                        final String mail = users?.email ?? '';

                        try {
                          String? encodeQueryParameters(
                              Map<String, String> params) {
                            return params.entries
                                .map((MapEntry<String, String> e) =>
                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                .join('&');
                          }

                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: mail,
                          );
                          launchUrl(emailLaunchUri);
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: UsersIconsButton(
                      icon: const Icon(
                        Icons.my_location,
                      ),
                      onPress: () async {
                        final String latitude =
                            users?.location?.coordinates?.latitude ?? '';
                        final String longitude =
                            users?.location?.coordinates?.longitude ?? '';
                        try {
                          await launchUrlString(
                              'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ValueListenableBuilder(
                  valueListenable: currentIndex,
                  builder: (context, _, __) {
                    return Row(
                      children: [
                        Expanded(
                            child: UsersTextButton(
                                text: 'Men',
                                isActive: currentIndex.value == 0,
                                onPressed: () {
                                  currentIndex.value = 0;
                                })),
                        const SizedBox(width: 15),
                        Expanded(
                            child: UsersTextButton(
                                text: 'Both',
                                isActive: currentIndex.value == 1,
                                onPressed: () {
                                  currentIndex.value = 1;
                                })),
                        const SizedBox(width: 15),
                        Expanded(
                          child: UsersTextButton(
                            text: 'Women',
                            isActive: currentIndex.value == 2,
                            onPressed: () {
                              currentIndex.value = 2;
                            },
                          ),
                        ),
                      ],
                    );
                  }),
              const SizedBox(height: 24),
              const Text(
                ' 1 user session generator',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              RefreshButton(
                isLoading: state is LoadingState,
                onPressed: () {
                  BlocProvider.of<UsersCubit>(context)
                      .getUsers(mode: getGender);
                },
              ),
              const SizedBox(
                height: 24,
              ),
              ValueListenableBuilder(
                  valueListenable: currentIndex,
                  builder: (context, _, __) {
                    return Text(
                      '$getMode mode',
                      textAlign: TextAlign.center,
                    );
                  }),
            ],
          );
        },
      ),
    );
  }

  String get getGender {
    String value = '';
    switch (currentIndex.value) {
      case 0:
        value = 'male';
        break;
      case 2:
        value = 'female';
        break;
    }
    return value;
  }

  String get getMode {
    String value = '';
    switch (currentIndex.value) {
      case 0:
        value = 'Men';
        break;
      case 1:
        value = 'Both';
        break;
      case 2:
        value = 'Women';
        break;
    }
    return value;
  }

  // Color changeColor(currentIndex) {
  //   switch (currentIndex.value) {
  //     case 0:
  //       return Colors.red;
  //     case 1:
  //       return Colors.amber;
  //     case 2:
  //       return Colors.amber;
  //   }
  //   return changeColor(currentIndex);
  // }
}
