import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inter_task/screen/screen_one.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? selectedAge;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> list = ["18", "19", "20", "21", "22"];
  String address = "";
  String bio = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
        title: Text(FirebaseAuth.instance.currentUser!.displayName!),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Address',
                ),
                onChanged: (value) {
                  address = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Fill the fields";
                  } else {
                    return null;
                  }
                },
              ),
              DropdownButton<String>(
                hint: Text('Select You Age'),
                value: selectedAge,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: SizedBox(),
                onChanged: (String? value) {
                  setState(() {
                    selectedAge = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Bio',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Fill the fields";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  bio = value;
                },
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      saveUserProfile();
                    } else {
                      return null;
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenOne(),
                      ),
                    );
                  },
                  child: const Text('Screen 1'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveUserProfile() async {
    FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({"address": address, "age": selectedAge ?? "18", "bio": bio})
        .then((value) => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenOne(),
                ),
              )
            })
        .catchError((error, stackTrace) {
          print("error occured");
          print(error.toString());
        });
  }
}
