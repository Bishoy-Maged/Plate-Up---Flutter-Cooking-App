import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plate_up/Widget/food_items_display.dart';
import 'package:plate_up/Widget/my_icon_button.dart';
import '../Utils/constants.dart';

class ViewAllItems extends StatefulWidget {
  const ViewAllItems({super.key});

  @override
  State<ViewAllItems> createState() => _ViewAllItemsState();
}

class _ViewAllItemsState extends State<ViewAllItems> {
  final CollectionReference completeMeals =
  FirebaseFirestore.instance.collection('Meals');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          const SizedBox(width: 15),
          MyIconButton(
              icon: Icons.arrow_back_ios_new,
              pressed: () {
                Navigator.pop(context);
              }),
          const Spacer(),
          const Text(
            "All Recipes :)",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          MyIconButton(icon: Iconsax.filter, pressed: () {}),
          const SizedBox(width: 15),
        ],
      ),
      body: StreamBuilder(
        stream: completeMeals.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: streamSnapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.76, // Adjusted to avoid overflow
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final documentSnapshot = streamSnapshot.data!.docs[index];
                return FoodItemsDisplay(documentSnapshot: documentSnapshot);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
