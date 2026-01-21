import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/screens/cart/quantity_btm_sheet.dart';
import 'package:glossyprojekat/widgets/subtitle_text.dart';
import 'package:glossyprojekat/widgets/title_text.dart';
import 'package:iconly/iconly.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return FittedBox(
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Slika proizvoda sa shimmer efektom kao na vežbama
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: FancyShimmerImage(
                  imageUrl: "https://t4.ftcdn.net/jpg/03/23/02/09/360_F_323020942_S6Y7v9eK1C7YfP1I9f9YxH9p7YvR0B4W.jpg", 
                  height: size.height * 0.2,
                  width: size.height * 0.2,
                  boxFit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              IntrinsicWidth(
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Naslov proizvoda
                        SizedBox(
                          width: size.width * 0.6,
                          child: const TitelesTextWidget(
                            label: "Naziv proizvoda", 
                            maxLines: 2,
                          ),
                        ),
                        // Dugmići za brisanje (ikona X kao na vežbama)
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        // Cena
                        const SubtitleTextWidget(
                          label: "1200 RSD",
                          color: Color.fromARGB(255, 226, 143, 171),
                        ),
                        const Spacer(),
                        // Dugme za količinu koje otvara onaj BottomSheet koji smo napravili
                        OutlinedButton.icon(
                          onPressed: () async {
                            await showModalBottomSheet(
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return const QuantityBottomSheetWidget();
                              },
                            );
                          },
                          icon: const Icon(IconlyLight.arrow_down_2),
                          label: const Text("Kol: 1"),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(width: 1, color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}