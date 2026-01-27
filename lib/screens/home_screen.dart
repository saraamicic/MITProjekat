import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:glossyprojekat/consts/app_colors.dart';
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
    
    final latestArrivals = AppConstants.products
        .where((element) => !element.isBestseller)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Glossy'), centerTitle: true),
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
                    activeColor: AppColors.glossyPink, 
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

            const SizedBox(height: 8),

            // Latest arrival
            SizedBox(
              height: size.height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: latestArrivals.length,
                itemBuilder: (context, index) {
                  return LatestArrivalProductWidget(
                    productModel: latestArrivals[index],
                  );
                },
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0,
              top: 20, bottom: 5), 
              child: TitelesTextWidget(label: "Najbolje prodavani",),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: size.height * 0.20,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bestSellers.length,
                itemBuilder: (context, index) {
                  return LatestArrivalProductWidget(
                    productModel: bestSellers[index],
                  );
                },
              ),
            ),

            const SizedBox(height: 50),
            
            Center(
              child: Text(
                'Dobrodošli u Glossy beauty zonu',
                style: GoogleFonts.montserrat( 
                  fontSize: 18,
                  fontWeight: FontWeight.w800, 
                  color: Colors.black,
                ),
              ),
            ),

            // O nama na dnu
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 40.0,
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                 
                  color:Color.fromARGB(255, 253, 235, 236).withOpacity(0.4), 
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: AppColors.glossyPink.withOpacity(0.3), 
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitelesTextWidget(label: "O nama", fontSize: 20,),
                    const SizedBox(height: 12),
                    SubtitleTextWidget(
                      label:
                          "Dobrodošli u Glossy, vašu omiljenu destinaciju za vrhunsku negu, lepotu i svakodnevno uživanje. Naša misija je da vam omogućimo pristup najkvalitetnijim proizvodima svetskih brendova koji su pažljivo birani da istaknu vašu prirodnu lepotu. \n\nVerujemo da svaka osoba zaslužuje trenutke luksuza u svojoj rutini, bez obzira na to koliko dan bio užurban. \n\n"
                          "Naš tim stručnjaka neprestano istražuje tržište kako bi vam doneo najnovije trendove i proverene formule kojima možete verovati. U Glossy porodici, fokus je uvek na autentičnosti, održivosti i stvaranju besprekornog iskustva kupovine za svakog korisnika.\n\n"
                          "Svaki proizvod u našoj ponudi nosi pečat kvaliteta jer verujemo da je nega kože i tela najlepši oblik brige o sebi. Budite sjajni, budite inspirisani i dozvolite nam da budemo deo vaše priče o lepoti – uz Glossy.",
                      fontSize: 14,
                      fontWeight: FontWeight.w400, 
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