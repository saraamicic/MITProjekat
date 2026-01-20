import 'package:glossyprojekat/models/product_model.dart';
import 'package:glossyprojekat/services/assets_menager.dart';

class AppConstants {
  static List<String> bannersImages = [
    '${AssetsMenager.bannerPath}/banner5.jpg',
    '${AssetsMenager.bannerPath}/banner7.jpg',
    '${AssetsMenager.bannerPath}/banner3.jpg',
  ];

  //kao neki recnik da znam koje podkategorije pripadaju kojoj nadkategoriji

  static List<Map<String, dynamic>> categories = [
  {
    'name': 'Šminka',
    'image': '${AssetsMenager.iconPath}/lipstick.png', 
    'subCategories': ['Lice', 'Oči', 'Usne', 'Pribor za šminkanje'],
  },
  {
    'name': 'Nega lica',
    'image': '${AssetsMenager.iconPath}/cleanser.png',
    'subCategories': ['Čišćenje lica', 'Nega usana', 'Kreme', 'Maske za lice', 'Serumi',  'Pilinzi'],
  },
  {
    'name': 'Nega tela',
    'image': '${AssetsMenager.iconPath}/bodybutter.png',
    'subCategories': <String>[],
  },

  {
    'name': 'Proizvodi za kosu',
    'image': '${AssetsMenager.iconPath}/hairdryer.png',
    'subCategories': ['Šamponi', 'Regeneratori i maske', 'Dodatna nega kose','Oblikovanje kose'],

  },

  {
    'name': 'Parfemi',
    'image': '${AssetsMenager.iconPath}/parfum.png',
    'subCategories': ['Za nju', 'Za njega'],

  },

  {
    'name': 'Poklon setovi',
    'image': '${AssetsMenager.iconPath}/giftset.png',
    'subCategories':  <String>[],
  },

];

  //ovo mi treba za hardkodovanje proizvoda za latest arrival i bestsellers
  static const List<ProductModel> products = [
    ProductModel(
      id: '1',
      title: 'Velnea Niacinamid set dnevna+noćna krema 2X50ml',
      price: 799.99,
      category: 'Kreme',
      image: 'https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/8/6/8606034398933.jpg',
      description: 'VELNEA NIACINAMID SET sadrži dnevnu i noćnu kremu koje su namenjene svakodnevnoj anti-age nezi kože.VELNEA  DNEVNA KREMA ZA LICE SA NIACINAMIDOM   razvijena je za potrebe zrele kože lica nakon 55. godine. Bazirana je na dokazanom pozitivnom dejstvu tripeptida, kao i ekstraktu sojinih klica bogatih fitoestrogenima u anti-age tretmanu kože.',
      isBestseller: false,
    ),
    ProductModel(
      id: '2',
      title: 'Mixa krema protiv suvoće kože 50ml',
      price: 999.99,
      category: 'Kreme',
      image: 'https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/3/6/3600551156750.jpg',
      description: 'Kombinacija dermatološki aktivnih sastojaka. Hijaluronska kiselina: Poznata po svojim intenzivno hidratantnim svojstvima, pomaže u borbi protiv veoma isušene kože.  Skvalan: Poznat po svojstvu da jača barijernu funkciju kože, kao i po tome da smanjuje zategnutost i osećaj nelagodnosti.',
      isBestseller: false,
    ),
    ProductModel(
      id: '3',
      title: 'Mixa Hyaluronic intenzivno hidratantni losion za telo 400ml',
      price: 659.99,
      category: 'Nega tela',
      image: 'https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/3/6/3600550958430_1.jpg' ,
      description: 'Trenutna hidratacija. Intenzivna 48-časovna hidratacija. Tekstura je lagana i nemasna, upija se za 10 sekundi.Testirano pod medicinskom kontrolom.',
      isBestseller: false,
    ),

    ProductModel(
      id: '4',
      title: 'Garnier Micelarna voda sa efektom blagog pilinga 400ml',
      price: 489.99,
      category: 'Čišćenje lica',
      image: 'https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/3/6/3600542607599_1.jpg' ,
      description: 'Garnier Micelarna voda sa efektom blagog pilinga Čisti, uklanja šminku, a piling efekat pruža ujednačen ten. Sadrži micele koje privlače i uklanjaju.',
      isBestseller: false,
    ),

    ProductModel(
      id: '5',
      title: 'Maybelline New York Lifter Stix bronzer i kontur stik 30',
      price: 929.99,
      category: 'Lice',
      image: 'https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/3/6/3600531702052.jpg' ,
      description: 'Konturisanje ima novo ime! Upoznaj Maybelline New York Lifter Stix bronzer i kontur stikove. Lažiraj facelift i podigni svaki ugao lica bez napora. Kremasta formula obogaćena ekstraktom brusnice se neverovatno lako stapa sa kožom. Pogodno za sve tipove kože, čak i osetljivu.\n\n',
      isBestseller: false,
    ),

    //ovi dole ce biti bestseleri
    ProductModel(
      id: '10',
      title: 'NYX Professional Makeup Jelly Job sjaj za usne 16 jellybean ',
      price: 1299.99,
      category: 'Usne',
      image: 'https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/8/0/800897276096.jpg',
      description: 'Sve što tvoje usne žele! – neka tvoje usne budu sjajne kao staklo i sočne kao žele uz novi Jelly Job! Samo jedan potez naše lagane formule sa našim novim aplikatorom u obliku spatule pružiće ti žele-gladak sjaj i žele-sočan volumen za staklene, visokosjajne usne iz tvojih snova. ',
      isBestseller: true,
    ),

    ProductModel(
      id: '6',
      title: 'NYX Professional Makeup Epic Wear Liquid Liner ajlajner - Sapphire',
      price: 1579.99,
      category: 'Oči',
      image: 'https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/8/0/800897197186.jpg' ,
      description: 'Visoko pigmentisan tečni ajlajner za lice i telo. Vodootporan i ne razmazuje se s neverovatnim mat finišom. Fleksibilni vrh daje savršenu preciznost. Dostupan u 6 nijansi. Nijansa: Sapphire',
      isBestseller: true,
    ),

    ProductModel(
      id: '7',
      title: 'Lebelage Capsule Aqua maska za lice 28ml',
      price: 179.99,
      category: 'Maske za lice',
      image: 'https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/8/8/8809446658798.jpg' ,
      description: 'Lebelage Capsule Aqua maska za lice pruža koži dubinsku hidrataciju i osveženje, čineći je mekom i elastičnom. Obogaćena moćnim hidratantnim sastojcima, ova maska pomaže u obnavljanju nivoa vlage u koži, pružajući osećaj svežine. Zahvaljujući praktičnom "capsule" pakovanju, maska čuva svežinu aktivnih sastojaka.',
      isBestseller: true,
    ),

    ProductModel(
      id: '8',
      title: 'Ziaja maska i piling za lice sa voćnim kiselinama 55ml',
      price: 759.99,
      category: 'Pilinzi',
      image: 'https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/5/9/5901887057130.jpg' ,
      description: 'Proizvod koji kombinuje svojstva nežnog pilinga i maske. Guste je i kremaste teksture, nežnog mirisa. Preporučuje se za masnu, kombinovanu, normalnu kožu lica. Namenjena je osobama od 18+ godina. Hranljivi sastojci formule pojačavaju aktivni efekat maske. Osvežava i čisti kožu i sužava proširene pore.',
      isBestseller: true,
    ),

    ProductModel(
      id: '9',
      title: 'Ziaja Cocoa Butter gel za tuširanje sa kakao maslacem 500 ml',
      price: 439.99,
      category: 'Nega tela',
      image: 'https://www.lilly.rs/media/catalog/product/cache/8bd1c2c6eb0077b12ecfb0078340c065/5/9/5901887008316_1.jpg' ,
      description: 'Ziaja gel za tuširanje sa kakao maslacem predstavlja proizvod poljskog brenda Ziaja koji pruža Vašoj koži potrebnu negu i hidrataciju. Intenzivno hrani i hidrira kožu, sprečava gubitak vode, što kožu čini mekom i elastičnom. Sadrži kakao maslac i provitamin B5 koji Vašoj koži pružaju dodatnu negu i hidrataciju, čineći je mekanom i nežnom na dodir.',
      isBestseller: true,
    ),
    





  ];

}
