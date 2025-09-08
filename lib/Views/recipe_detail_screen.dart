import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../Provider/favorite_provider.dart';
import '../Utils/constants.dart';
import '../Widget/my_icon_button.dart';

class RecipeDetailScreen extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const RecipeDetailScreen({super.key, required this.documentSnapshot});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {},
        label: Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 95,
                  vertical: 10,
                ),
                foregroundColor: Colors.white,
              ),
              onPressed: () {},
              child: const Text(
                "Start Cooking",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(width: 5),
            IconButton(
              style: IconButton.styleFrom(
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.grey.shade300,
                    width: 2,
                  ),
                ),
              ),
              onPressed: () {
                provider.toggleFavorite(widget.documentSnapshot);
              },
              icon: Icon(
                provider.isFavorite(widget.documentSnapshot)
                    ? Iconsax.heart5
                    : Iconsax.heart,
                color: provider.isFavorite(widget.documentSnapshot)
                    ? Colors.red
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Recipe image
                Hero(
                  tag: widget.documentSnapshot['image'],
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.documentSnapshot['image'],
                        ),
                      ),
                    ),
                  ),
                ),
                // Back button
                Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      MyIconButton(
                        icon: Icons.arrow_back_ios_new,
                        pressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.width,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            // drag handle
            Center(
              child: Container(
                width: 40,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade300,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // recipe details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name
                  Text(
                    widget.documentSnapshot['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // calories & time
                  Row(
                    children: [
                      const Icon(Iconsax.flash_1,
                          size: 20, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.documentSnapshot['cal']} Cal",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(" . ",
                          style: TextStyle(
                              color: Colors.grey, fontSize: 15)),
                      const Icon(Iconsax.clock,
                          size: 20, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.documentSnapshot['time']} Min",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // rating & reviews
                  Row(
                    children: [
                      const Icon(Iconsax.star1,
                          size: 20, color: Colors.amberAccent),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.documentSnapshot['rating']}/5",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const Text(" . ",
                          style: TextStyle(
                              color: Colors.grey, fontSize: 15)),
                      const Icon(Icons.person_outline,
                          size: 20, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text(
                        "${widget.documentSnapshot['reviews']} Reviews",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ingredients section //
                  const Text(
                    "Ingredients",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // ingredients list //
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                    widget.documentSnapshot['ingredientsName'].length,
                    itemBuilder: (context, index) {
                      final image =
                      widget.documentSnapshot['ingredientsImage'][index];
                      final name =
                      widget.documentSnapshot['ingredientsName'][index];
                      final amount =
                      widget.documentSnapshot['ingredientsAmount'][index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            // ingredient image
                            CircleAvatar(
                              backgroundImage: NetworkImage(image),
                              radius: 22,
                            ),
                            const SizedBox(width: 12),

                            // ingredient name : amount
                            Expanded(
                              child: Text(
                                "$name : $amount",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
