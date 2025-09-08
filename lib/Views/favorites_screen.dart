import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../Provider/favorite_provider.dart';
import '../Utils/constants.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final favoriteItems = provider.favorites;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        centerTitle: true,
        title: Text(
          "Favorites",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

      ),
      body: favoriteItems.isEmpty? const Center(
        child: Text(
            "No Favorites yet",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ): ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          String favorites = favoriteItems[index];
          return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('Meals').doc(favorites).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child:
                  Text('Error loading favorites',)
                  );
                }
                var favoriteItem = snapshot.data!;
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(favoriteItem['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  favoriteItem['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                // Calories & Time
                                Row(
                                  children: [
                                    const Icon(Iconsax.flash_1,
                                        size: 14, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      "${favoriteItem['cal']} Cal",
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
                                      "${favoriteItem['time']} Min",
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
                                      "${favoriteItem['rating']}/5",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    //const SizedBox(width: 4),
                                    const Text(
                                      " . ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const Icon(Icons.person_outline,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 2),
                                    Text(
                                      "${favoriteItem['reviews']} Reviews",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(width: 15),
                            // for delete button
                            Positioned(
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      provider.toggleFavorite(favoriteItem);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
          );
        },
      ),
    );
  }
}
