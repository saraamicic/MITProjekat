import 'package:flutter/material.dart';
import 'package:glossyprojekat/widgets/title_text.dart';

class SubCategoryScreen extends StatelessWidget {
  static const routeName = "/SubCategoryScreen";

  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Primamo podatke koji su poslati iz CategoriesScreen
    final categoryData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String categoryName = categoryData['name'];
    final List<String> subCategories = categoryData['subCategories'];

    return Scaffold(
      appBar: AppBar(
        //naslov
        title: TitelesTextWidget(label: categoryName),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Vraća nas nazad na sve kategorije
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20),
        ),
      ),
      body: ListView.builder(
        itemCount: subCategories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/SearchScreen", 
                  arguments: subCategories[index], //saljemo ime subkat
                );
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  
                  border: Border.all(
                    color: const Color.fromARGB(
                      255,
                      226,
                      143,
                      171,
                    ).withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        subCategories[index],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
