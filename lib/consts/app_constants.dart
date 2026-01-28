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

}