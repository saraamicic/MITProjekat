import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/widgets/subtitle_text.dart';

class QuantityBottomSheetWidget extends StatelessWidget {
  const QuantityBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          height: 6,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.grey.shade400,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: 25, // lista brojeva od 1 do 25
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  log("Odabrana količina: ${index + 1}");
                  //  zatvori bottomSheet nakon klika na broj
                  Navigator.pop(context);
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0), 
                    child: SubtitleTextWidget(
                      label: "${index + 1}",
                      color: const Color.fromARGB(255, 0, 0, 0), 
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}