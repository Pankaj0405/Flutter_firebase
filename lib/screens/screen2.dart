import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_quest/widgets/card.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  String dropdownvalue = 'select';

  // List of items in our dropdown menu
  var items = [
    'select',
    'Facebook',
    'Organic',
    'Friend',
    'Google',
    'Instagram'
  ];
  final TextEditingController searchController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _bioController.dispose();
   searchController.dispose();
  }
  bool isShowUsers = false;
  bool isShowUsers1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            labelText: 'Search for a user',
            labelStyle: TextStyle(
              color: Colors.white
            )
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(top: 5),
            child: DropdownButton(


              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                  isShowUsers1 = true;
                  _bioController.text=newValue!;
                });
              },
            ),
          ),
        ],
      ),
      body: isShowUsers
    ? FutureBuilder(
    future: FirebaseFirestore.instance
        .collection('users')
        .where('username',
        isGreaterThan: searchController.text)
        .get(),
    builder: (context, snapshot) {
    if (!snapshot.hasData) {
    return const Center(
    child: CircularProgressIndicator(),
    );
    }
    return ListView.builder(
    itemCount: (snapshot.data! as dynamic).docs.length,
    itemBuilder: (context, index)=>Container(

      child: Card1(
        snap:snapshot.data!.docs[index].data(),
      ),
    ));
    },
    ): isShowUsers1? FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('bio',
            isEqualTo: _bioController.text)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index)=>Container(

                child: Card1(
                  snap:snapshot.data!.docs[index].data(),
                ),
              ));
        },
      ): Container(child: Center(child: Text("Search for User"),),)
    );;
  }
}
