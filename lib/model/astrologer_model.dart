import 'package:direction/utils/app_asset.dart';

class Astrologer {
  String name;
  String fee;
  String highFee;
  String expertise;
  String helped;
  String imageUrl;

  Astrologer({
    required this.name,
    required this.fee,
    required this.highFee,
    required this.expertise,
    required this.helped,
    required this.imageUrl,
  });
}

class AstrologerModel {
  List<Astrologer> data = [
    Astrologer(
      name: 'Pastor Joseph Fernandez',
      fee: '10/min',
      expertise: 'Marriage Issues',
      helped: '11,000+',
      imageUrl: AppAssets.png_astrologer_1,
      highFee: '25',
    ),
    // Add more unique astrologers as needed
    Astrologer(
      name: 'Father Daniel Jones',
      fee: '10/min',
      expertise: 'Relationship & Financial Issues',
      helped: '15,000+',
      imageUrl: AppAssets.png_astrologer_2,
      highFee: '25',
    ),

    Astrologer(
      name: 'Brother Ramesh Babu',
      fee: '10/min',
      expertise: 'Overcoming Addictions',
      helped: '650+',
      imageUrl: AppAssets.png_astrologer_3,
      highFee: '25',
    ),

    Astrologer(
      name: 'Sister Leena Daisy',
      fee: '10/min',
      expertise: 'Love Failure',
      helped: '11,000+',
      imageUrl: AppAssets.png_astrologer_4,
      highFee: '25',
    ),

    Astrologer(
      name: 'Pastor Rebecca Rosy',
      fee: '10/min',
      expertise: 'Marriage Issues',
      helped: '16,000+',
      imageUrl: AppAssets.png_astrologer_5,
      highFee: '25',
    ),
  ];
}

// Function to create and return an instance of AstrologerModel
AstrologerModel createAstrologerModel() {
  return AstrologerModel();
}
