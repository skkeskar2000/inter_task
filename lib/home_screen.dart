import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inter_task/cubit/sign_in_cubit.dart';
import 'package:inter_task/screen/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        print("bloc lister ");
        if (state is SignInSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(),
            ),
          );
        } else {
          print("---------------- Something Went Wrong -----------------");
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: FloatingActionButton.extended(
                icon: Icon(Icons.g_translate_outlined),
                onPressed: () {
                  BlocProvider.of<SignInCubit>(context).signIn();
                },
                label: const Text("Google Login")),
          ),
        );
      },
    );
  }
}
