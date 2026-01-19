import 'package:glossyprojekat/models/product_model.dart';

class AppConstants {
  static const List<String> bannersImages = [
    'assets/banner1.jpg',
    'assets/banner2.jpg',
    'assets/banner3.jpg',
  ];

  //ovo mi treba za hardkodovanje proizvoda za latest arrival i bestsellers
  static const List<ProductModel> products = [
    ProductModel(
      id: '1',
      title: 'Velnea Niacinamid set dnevna+noćna krema 2X50ml',
      price: 799.99,
      category: 'Nega lica',
      image: 'https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/8/6/8606034398933.jpg',
      description: 'VELNEA NIACINAMID SET sadrži dnevnu i noćnu kremu koje su namenjene svakodnevnoj anti-age nezi kože.VELNEA  DNEVNA KREMA ZA LICE SA NIACINAMIDOM   razvijena je za potrebe zrele kože lica nakon 55. godine. Bazirana je na dokazanom pozitivnom dejstvu tripeptida, kao i ekstraktu sojinih klica bogatih fitoestrogenima u anti-age tretmanu kože.',
    ),
    ProductModel(
      id: '2',
      title: 'Mixa krema protiv suvoće kože 50ml',
      price: 999.99,
      category: 'Nega lica',
      image: 'https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/3/6/3600551156750.jpg',
      description: 'Kombinacija dermatološki aktivnih sastojaka. Hijaluronska kiselina: Poznata po svojim intenzivno hidratantnim svojstvima, pomaže u borbi protiv veoma isušene kože.  Skvalan: Poznat po svojstvu da jača barijernu funkciju kože, kao i po tome da smanjuje zategnutost i osećaj nelagodnosti.'
    ),
    ProductModel(
      id: '3',
      title: 'Mixa Hyaluronic intenzivno hidratantni losion za telo 400ml',
      price: 659.99,
      category: 'Nega tela',
      image: 'https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/3/6/3600550958430_1.jpg' ,
      description: 'Trenutna hidratacija. Intenzivna 48-časovna hidratacija. Tekstura je lagana i nemasna, upija se za 10 sekundi.Testirano pod medicinskom kontrolom.'
    ),

    ProductModel(
      id: '4',
      title: 'Garnier Micelarna voda sa efektom blagog pilinga 400ml',
      price: 489.99,
      category: 'Nega lica',
      image: 'https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/3/6/3600542607599_1.jpg' ,
      description: 'Garnier Micelarna voda sa efektom blagog pilinga Čisti, uklanja šminku, a piling efekat pruža ujednačen ten. Sadrži micele koje privlače i uklanjaju.'
    ),

    ProductModel(
      id: '5',
      title: 'Maybelline New York Lifter Stix bronzer i kontur stik 30',
      price: 929.99,
      category: 'Sminka',
      image: 'https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/3/6/3600531702052.jpg' ,
      description: 'Konturisanje ima novo ime! Upoznaj Maybelline New York Lifter Stix bronzer i kontur stikove. Lažiraj facelift i podigni svaki ugao lica bez napora. Kremasta formula obogaćena ekstraktom brusnice se neverovatno lako stapa sa kožom. Pogodno za sve tipove kože, čak i osetljivu.\n\n'
    ),
  ];

}
