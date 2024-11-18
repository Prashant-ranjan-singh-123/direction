import 'package:direction/utils/app_asset.dart';

class Astrologer {
  String name;
  String fee;
  String feeUsa;
  String highfeeUsa;
  String highFee;
  String expertise;
  String helped;
  String imageUrl;
  String userName;
  String userId;

  Astrologer(
      {required this.name,
      required this.fee,
      required this.highFee,
      required this.expertise,
      required this.helped,
      required this.imageUrl,
      required this.feeUsa,
      required this.highfeeUsa,
      required this.userName,
      required this.userId});
}

class AstrologerModel {
  List<Astrologer> data = [
    Astrologer(
      name: 'Pastor Joseph Fernandez',
      fee: '10/min',
      feeUsa: '1/min',
      expertise: 'Marriage Issues',
      helped: '11,000+',
      imageUrl: AppAssets.png_astrologer_1,
      highFee: '70',
      highfeeUsa: '5',
      userName: 'Pastor',
      userId: 'Pastor Joseph Fernandez',
    ),
    // Add more unique astrologers as needed
    Astrologer(
      name: 'Father Daniel Jones',
      fee: '10/min',
      expertise: 'Relationship & Financial Issues',
      helped: '15,000+',
      imageUrl: AppAssets.png_astrologer_2,
      highFee: '25',
      feeUsa: '1/min',
      highfeeUsa: '3',
      userName: 'Father',
      userId: 'Father Daniel Jones',
    ),

    Astrologer(
      name: 'Brother Ramesh Babu',
      fee: '10/min',
      expertise: 'Overcoming Addictions',
      helped: '650+',
      imageUrl: AppAssets.png_astrologer_3,
      highFee: '30',
      feeUsa: '1/min',
      highfeeUsa: '5',
      userName: 'Brother',
      userId: 'Brother Ramesh Babu',
    ),

    Astrologer(
      name: 'Sister Leena Daisy',
      fee: '10/min',
      expertise: 'Love Failure',
      helped: '11,000+',
      imageUrl: AppAssets.png_astrologer_4,
      highFee: '20',
      feeUsa: '1/min',
      highfeeUsa: '3',
      userName: 'Sister',
      userId: 'Sister Leena Daisy',
    ),

    Astrologer(
      name: 'Pastor Rebecca Rosy',
      fee: '10/min',
      expertise: 'Marriage Issues',
      helped: '16,000+',
      imageUrl: AppAssets.png_astrologer_5,
      highFee: '35',
      feeUsa: '1/min',
      highfeeUsa: '5',
      userName: 'Rebecca',
      userId: 'Pastor Rebecca Rosy',
    ),
  ];
}

// Function to create and return an instance of AstrologerModel
AstrologerModel createAstrologerModel() {
  return AstrologerModel();
}
