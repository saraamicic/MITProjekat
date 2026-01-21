import 'package:flutter/material.dart';
import 'package:glossyprojekat/widgets/subtitle_text.dart';
import 'package:glossyprojekat/widgets/title_text.dart';


class CartBottomWidget extends StatelessWidget {
  const CartBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        
        border: const Border(
          top: BorderSide(width: 1, color: Color.fromARGB(255, 249, 218, 219)), 
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: kBottomNavigationBarHeight + 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: TitelesTextWidget(
                        label: "Ukupno (5 proizvoda)",
                      ),
                    ),
                    SubtitleTextWidget(
                      label: "2200 RSD",
                      color: Color.fromARGB(255, 226, 143, 171), 
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // ovde logika za kupovinu
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 226, 143, 171), // dugmic za kupovinu
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Kupi"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}