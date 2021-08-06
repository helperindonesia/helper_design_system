import 'package:flutter/material.dart' hide OutlinedButton;
import 'package:helper_design/helper_design.dart';

class SurveyCategoryBottomSheet extends StatelessWidget {
  const SurveyCategoryBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SurveyCategoryModel> surveyCategoryList =
        SurveyCategoryModel.getCategory();
    return ModalBottomSheet(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Apa yang perlu Kami benahi?',
              style: HelperThemeData.textTheme.headline4,
            ),
            Text(
              'Masukanmu sangat berharga bagi Kami',
              style: HelperThemeData.textTheme.bodyText3!
                  .copyWith(color: HelperColors.black5),
            ),
          ],
        ),
      ),
      ListView.separated(
        shrinkWrap: true,
        itemCount: surveyCategoryList.length,
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: () {
              showModalBottomSheet<dynamic>(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return ModalBottomSheet(
                        firstIcon: Icons.arrow_back_rounded,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  surveyCategoryList[index].category,
                                  style: HelperThemeData.textTheme.headline4,
                                ),
                                Text(
                                  surveyCategoryList[index].description,
                                  style: HelperThemeData.textTheme.bodyText3!
                                      .copyWith(color: HelperColors.black5),
                                ),
                                SizedBox(height: 16.0),
                                OutlineTextField(
                                    minLines: 2,
                                    hintMaxLines: 2,
                                    hintText:
                                        surveyCategoryList[index].hintText),
                                SizedBox(height: 32.0),
                                PrimaryButton(
                                    text: 'Ok, Kirim', onPressed: () {}),
                              ],
                            ),
                          ),
                        ]);
                  });
            },
            child: ListTile(
              leading: Image.asset(
                surveyCategoryList[index].image,
                height: 40.0,
                width: 40.0,
              ),
              title: Text(
                surveyCategoryList[index].category,
                style: HelperThemeData.textTheme.headline5!
                    .copyWith(fontSize: 16.0),
              ),
              subtitle: Text(
                surveyCategoryList[index].description,
                style: HelperThemeData.textTheme.caption!
                    .copyWith(color: HelperColors.black5),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20.0,
              ),
            ),
          );
        },
        separatorBuilder: (_, int index) => Divider(
          thickness: 0.75,
          indent: 68.0,
        ),
      )
    ]);
  }
}

class SurveyCategoryModel {
  int categoryId;
  String category;
  String description;
  String image;
  String hintText;

  SurveyCategoryModel({
    required this.categoryId,
    required this.category,
    required this.description,
    required this.image,
    required this.hintText,
  });

  static List<SurveyCategoryModel> getCategory() {
    return <SurveyCategoryModel>[
      SurveyCategoryModel(
          categoryId: 1,
          category: 'Tampilan Aplikasi',
          description: 'Tentang fitur dan desain aplikasi',
          image: 'assets/images/tampilan_aplikasi.png',
          hintText: 'Contoh: Tombol detail kebutuhan kurang jelas'),
      SurveyCategoryModel(
          categoryId: 2,
          category: 'Kinerja Helper',
          description: 'Tingkat kepuasanmu kepada Helper',
          image: 'assets/images/kinerja_helper.webp',
          hintText: 'Contoh: Helpernya perlu lebih cepat lagi dong'),
      SurveyCategoryModel(
          categoryId: 3,
          category: 'Biaya Jasa',
          description: 'Range harga yang ditawarkan',
          image: 'assets/images/biaya_jasa.webp',
          hintText: 'Contoh: Beri potongan untuk pengguna setia dong'),
      SurveyCategoryModel(
          categoryId: 4,
          category: 'Lainnya',
          description: 'Ketiga kategori diatas dan hal lainnya',
          image: 'assets/images/kategori_lainnya.webp',
          hintText:
              'Contoh: Metode pembayaran hanya bisa menggunakan Helpcash dan Tunai'),
    ];
  }
}
