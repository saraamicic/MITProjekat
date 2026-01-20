import 'package:flutter/material.dart';
import 'package:glossyprojekat/consts/app_constants.dart';
import 'package:glossyprojekat/widgets/title_text.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitelesTextWidget(label: "Kategorije"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: AppConstants.categories.length,
        itemBuilder: (context, index) {
          final category = AppConstants.categories[index];
          
          return GestureDetector(
            onTap: () {
              // Ovde ćemo kasnije dodati navigaciju na podkategorije
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // 
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          category['image'],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    // 
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitelesTextWidget(
                            label: category['name'],
                            fontSize: 20,
                          ),
                          
                        ],
                      ),
                    ),
                    // Mala strelica na kraju
                    const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}