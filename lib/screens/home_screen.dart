import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/consts/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glossyprojekat/consts/app_colors.dart';
import 'package:glossyprojekat/widgets/products/latest_arrivals.dart';
import 'package:glossyprojekat/widgets/subtitle_text.dart';
import 'package:glossyprojekat/widgets/title_text.dart';
import 'package:glossyprojekat/models/product_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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

            SizedBox(
              height: size.height * 0.2,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .where( 'isNew', isEqualTo: true,) 
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("Nema dostupnih noviteta"));
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final productModel = ProductModel.fromFirestore(
                        snapshot.data!.docs[index],
                      );
                      return LatestArrivalProductWidget(
                        productModel: productModel,
                      );
                    },
                  );
                },
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(
                left: 12.0,
                right: 12.0,
                top: 20,
                bottom: 5,
              ),
              child: TitelesTextWidget(label: "Najbolje prodavani"),
            ),

            const SizedBox(height: 5),

            SizedBox(
              height: size.height * 0.20,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .where('isBestseller', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("Nema dostupnih bestsellera"),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final productModel = ProductModel.fromFirestore(
                        snapshot.data!.docs[index],
                      );
                      return LatestArrivalProductWidget(
                        productModel: productModel,
                      );
                    },
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

            // O nama deo
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 40.0,
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    253,
                    235,
                    236,
                  ).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: AppColors.glossyPink.withOpacity(0.3),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitelesTextWidget(label: "O nama", fontSize: 20),
                    SizedBox(height: 12),
                    SubtitleTextWidget(
                      label:
                          "Dobrodošli u Glossy, vašu omiljenu destinaciju za vrhunsku negu, lepotu i svakodnevno uživanje...",
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
