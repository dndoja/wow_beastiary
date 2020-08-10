import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wow_armory/api/blizzard_api_client.dart';
import 'package:wow_armory/home/home_cubit.dart';
import 'package:wow_armory/home/home_page.dart';

final authClient = BlizzardAuthClient();
final apiClient = BlizzardApiClient(authClient);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('WoW Bestiary'),
          ),
          body: BlocProvider<HomeCubit>(
              create: (context) => HomeCubit(apiClient), child: HomePage()),
        ));
  }
}
