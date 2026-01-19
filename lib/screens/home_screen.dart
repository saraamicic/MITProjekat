import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/widgets/products/latest_arrivals.dart';
import 'package:glossyprojekat/widgets/subtitle_text.dart';
import 'package:glossyprojekat/widgets/title_text.dart';
import '../consts/app_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final bestSellers = AppConstants.products
        .where((element) => element.isBestseller)
        .toList();
    //Uzimamo sve proizvode kojima je isBestseller postavljen na false
    final latestArrivals = AppConstants.products
        .where((element) => !element.isBestseller)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Banneri
            SizedBox(
              height: size.height * 0.25,
              child: Swiper(
                autoplay: true,
                itemCount: AppConstants.bannersImages.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    AppConstants.bannersImages[index],
                    fit: BoxFit.cover,
                  );
                },
                pagination: const SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    activeColor: Color.fromARGB(255, 198, 123, 144),
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: TitelesTextWidget(label: "Noviteti"),
            ),

            const SizedBox(height: 15),

            //Latest arrival
            SizedBox(
              height: size.height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: latestArrivals.length,
                itemBuilder: (context, index) {
                  return LatestArrivalProductWidget(
                    productModel:
                        latestArrivals[index], //samo one iz latest arrival
                  );
                },
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
              child: TitelesTextWidget(label: "Najbolje prodavani"),
            ),

            const SizedBox(height: 15),
            SizedBox(
              height: size.height * 0.20,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bestSellers.length, // Koristi filtriranu listu
                itemBuilder: (context, index) {
                  return LatestArrivalProductWidget(
                    productModel:
                        bestSellers[index], //samo Bestseller proizvode
                  );
                },
              ),
            ),

            const SizedBox(height: 90),
            const Center(
              child: Text(
                'Dobrodosli u Glossy beauty zonu ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // Boldovano
                  color: Color.fromARGB(255,226,143,171,
                  ),
                ),
              ),
            ),

            //o nama na dnu
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 50.0,
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).cardColor.withOpacity(0.5), // Blaga pozadina
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: const Color.fromARGB(
                      255,
                      226,
                      143,
                      171,
                    ).withOpacity(0.3), // Nežna roze ivica
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitelesTextWidget(label: "O nama ", fontSize: 18),
                    const SizedBox(height: 10),
                    SubtitleTextWidget(
                      label:
                          "Dobrodošli u Glossy, vašu omiljenu destinaciju za vrhunsku negu, lepotu i svakodnevno uživanje. Naša misija je da vam omogućimo pristup najkvalitetnijim proizvodima svetskih brendova koji su pažljivo birani da istaknu vašu prirodnu lepotu. \n\n Verujemo da svaka osoba zaslužuje trenutke luksuza u svojoj rutini, bez obzira na to koliko dan bio užurban."
                          "Naš tim stručnjaka neprestano istražuje tržište kako bi vam doneo najnovije trendove i proverene formule kojima možete verovati. U Glossy porodici, fokus je uvek na autentičnosti, održivosti i stvaranju besprekornog iskustva kupovine za svakog korisnika.\n\n"
                          "Svaki proizvod u našoj ponudi nosi pečat kvaliteta jer verujemo da je nega kože i tela najlepši oblik brige o sebi. Budite sjajni, budite inspirisani i dozvolite nam da budemo deo vaše priče o lepoti – uz Glossy.",

                      fontSize: 14,
                      // maxLines: 10, // Opciono ako želiš da osiguraš da se sve vidi
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
