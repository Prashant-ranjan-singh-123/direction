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
      fee: '1/min',
      expertise: 'Marriage Issues',
      helped: '11,000+',
      imageUrl: AppAssets.png_astrologer_1,
      highFee: '5',
    ),
    // Add more unique astrologers as needed
    Astrologer(
      name: 'Pastor Jane Doe',
      fee: '1/min',
      expertise: 'Career Guidance',
      helped: '8,000+',
      imageUrl: AppAssets.png_astrologer_2,
      highFee: '3',
    ),

    Astrologer(
      name: 'Pastor Jane Doe',
      fee: '1/min',
      expertise: 'Career Guidance',
      helped: '8,000+',
      imageUrl: AppAssets.png_astrologer_3,
      highFee: '5',
    ),

    Astrologer(
      name: 'Pastor Jane Doe',
      fee: '1/min',
      expertise: 'Career Guidance',
      helped: '8,000+',
      imageUrl: AppAssets.png_astrologer_4,
      highFee: '3',
    ),

    Astrologer(
      name: 'Pastor Jane Doe',
      fee: '1/min',
      expertise: 'Career Guidance',
      helped: '8,000+',
      imageUrl: AppAssets.png_astrologer_5,
      highFee: '5',
    ),
  ];
}

// Function to create and return an instance of AstrologerModel
AstrologerModel createAstrologerModel() {
  return AstrologerModel();
}
