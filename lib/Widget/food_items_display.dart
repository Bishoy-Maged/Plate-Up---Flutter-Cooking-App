import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plate_up/Views/recipe_detail_screen.dart';
import '../Provider/favorite_provider.dart';

class FoodItemsDisplay extends StatelessWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const FoodItemsDisplay({super.key, required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);

    return GestureDetector(
      onTap: () {
        // Navigate to the recipe detail screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>
            RecipeDetailScreen(documentSnapshot: documentSnapshot),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.grey.shade100, // off-white card
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food Image (expanded to avoid overflow)
                  Expanded(
                    child: Hero(
                      tag: documentSnapshot['image'],
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              documentSnapshot['image'],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Food Name
                  Text(
                    documentSnapshot['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Calories & Time
                  Row(
                    children: [
                      const Icon(Iconsax.flash_1,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        "${documentSnapshot['cal']} Cal",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        " . ",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const Icon(Iconsax.clock,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        "${documentSnapshot['time']} Min",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Rating & Reviews
                  Row(
                    children: [
                      const Icon(Iconsax.star1,
                          size: 16, color: Colors.amberAccent),
                      const SizedBox(width: 4),
                      Text(
                        "${documentSnapshot['rating']}/5",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.person_outline,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text(
                        "${documentSnapshot['reviews']} Reviews",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Favorite button
              Positioned(
                top: 6,
                right: 6,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: InkWell(
                    onTap: () {
                      provider.toggleFavorite(documentSnapshot);
                    },
                    child: Icon(
                      provider.isFavorite(documentSnapshot)
                          ? Iconsax.heart5
                          : Iconsax.heart,
                      color: provider.isFavorite(documentSnapshot)
                          ? Colors.red
                          : Colors.black,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
