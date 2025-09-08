import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Utils/constants.dart';

class selectedCategory extends StatefulWidget {
  const selectedCategory({super.key});

  @override
  State<selectedCategory> createState() => _selectedCategoryState();
}
String category = "All";
final CollectionReference categoriesItems =
FirebaseFirestore.instance.collection('App - Category');

class _selectedCategoryState extends State<selectedCategory> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder( stream: categoriesItems.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: Row(children: List.generate(
                streamSnapshot.data!.docs.length, (index) =>
                  GestureDetector(onTap: () {
                    setState(() {
                      category = streamSnapshot.data!.docs[index]['name'];
                    });
                  },
                    child: Container(decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: category == streamSnapshot.data!.docs[index]['name'] ?
                      kPrimaryColor : Colors.white,
                    ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.only(right: 20),
                      child: Text(streamSnapshot.data!.docs[index]['name'],
                        style: TextStyle(
                          color: category == streamSnapshot.data!.docs[index]['name'] ?
                          Colors.white : Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        });
  }
}
