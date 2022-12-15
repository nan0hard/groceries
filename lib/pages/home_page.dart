import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groceries/model/cart_model.dart';
import 'package:provider/provider.dart';

import '../components/grocery_item_tile.dart';
import 'cart_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CartPage();
                  },
                ),
              ),
          backgroundColor: Colors.black,
          child: const Icon(Icons.shopping_bag)),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            //Good Morning
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text('Good Morning'),
            ),

            const SizedBox(height: 4),

            //Let's order some fresh items for you
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Let's order fresh items for you",
                style: GoogleFonts.notoSerif(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Divider
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Divider(),
            ),

            //Grid Items
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text('Fresh Items', style: TextStyle(fontSize: 18)),
            ),

            Expanded(
              child: Consumer<CartModel>(
                builder: (context, value, child) {
                  return GridView.builder(
                    itemCount: value.shopItems.length,
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1 / 1.3,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return GroceryItemTile(
                        itemName: value.shopItems[index][0],
                        itemPrice: value.shopItems[index][1],
                        imagePath: value.shopItems[index][2],
                        color: value.shopItems[index][3],
                        onPressed: () {
                          Provider.of<CartModel>(context, listen: false)
                              .addItemToCart(index);
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
