import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:glossyprojekat/widgets/products/latest_arrivals.dart';
import 'package:glossyprojekat/widgets/title_text.dart';
import '../consts/app_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
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
              child: TitelesTextWidget(label: "Latest Arrival"),
            ),

            const SizedBox(height: 15),

            //Latest arrival
            SizedBox(
              height: size.height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: AppConstants.products.length,
                itemBuilder: (context, index) {
                  return LatestArrivalProductWidget(
                    productModel: AppConstants.products[index],
                  );
                },
              ),
            ),
            
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Welcome to the Glossy beauty zone',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}