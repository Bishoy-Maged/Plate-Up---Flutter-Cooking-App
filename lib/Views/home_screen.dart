import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plate_up/Utils/constants.dart';
import 'package:plate_up/Views/view_all_items.dart';
import 'package:plate_up/Widget/banner.dart';
import 'package:plate_up/Widget/my_icon_button.dart';
import 'package:plate_up/Widget/selectedCategory.dart';
import '../Widget/food_items_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String category = "All";
  final CollectionReference categoriesItems =
  FirebaseFirestore.instance.collection('App - Category');

  Query get filteredRecipes => FirebaseFirestore.instance
      .collection('Meals')
      .where('category', isEqualTo: category);

  Query get allRecipes => FirebaseFirestore.instance.collection('Meals');

  Query get selectedRecipes =>
      category == "All" ? allRecipes : filteredRecipes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 5),
                    //--------------Header-----------//
                    Row(
                      children: [
                        const Text(
                          "What are you\n cooking today?",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        const Spacer(),
                        MyIconButton(
                          icon: Iconsax.notification,
                          pressed: () {},
                        ),
                      ],
                    ),
                    //-----------Search Bar---------//
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.search_normal_1),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          hintText: "Search any recipes",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    //-------------Banner----------//
                    const BannerToExplore(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //-----------Categories-------//
                    const selectedCategory(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Quick & Easy",
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 0.1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const ViewAllItems()));
                          },
                          child: Text(
                            "View all",
                            style: TextStyle(
                              color: kBannerColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // -------- Recipes (Horizontal Scroll) -------- //
              StreamBuilder(
                stream: selectedRecipes.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No recipes found"));
                  }

                  final List<DocumentSnapshot> recipes = snapshot.data!.docs;

                  return Padding(
                    padding: const EdgeInsets.only(top: 5, left: 15),
                    child: SizedBox(
                      height: 250, // ✅ fixed height for horizontal scroll
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: recipes.length,
                        separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 200, // ✅ fixed width for each card
                            child: FoodItemsDisplay(
                                documentSnapshot: recipes[index]),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
