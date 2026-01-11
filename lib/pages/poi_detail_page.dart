import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/extension/title_case_extension.dart';
import 'package:myplaces/models/poi_category.dart';

import '../components/common/poi_detail/add_list_custom.dart';
import '../components/common/poi_detail/add_list_default.dart';
import '../models/my_list.dart';
import '../models/poi.dart';
import '../models/poi_image.dart';
import '../providers.dart';

class PoiDetailPage extends ConsumerStatefulWidget {
  final Poi poi;

  const PoiDetailPage({super.key, required this.poi});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => PoiDetailPageState();
}

class PoiDetailPageState extends ConsumerState<PoiDetailPage> {
  @override
  Widget build(BuildContext context) {
    final images = [
      'https://picsum.photos/id/20/800/600',
      'https://picsum.photos/id/10/800/600',
      'https://picsum.photos/id/30/800/600',
    ];

    // Poi poi = Poi(
    //   id: "123",
    //   name: "Rho",
    //   province: "Milano",
    //   region: "Lombardia",
    //   country: "Italy",
    //   countrycode: "IT",
    //   categoryName: PoiCategory.city.name,
    // );
    Poi poi = widget.poi;
    poi.setImages(images.map(((i) => PoiImage(thumbnail: i))).toList());

    List<MyList> allDefinedLists = ref.read(myListRepositoryProvider).getAll();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: CarouselSlider(
                  items: poi.images.map((image) {
                    return Image.network(
                      image.thumbnail ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 300,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      // setState(() => _currentCarouselIndex = index);
                    },
                  ),
                ),
              ),

              // Fade
              Positioned(
                top: 200,
                left: 0,
                right: 0,
                height: 100,
                child: IgnorePointer(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black],
                      ),
                    ),
                  ),
                ),
              ),

              // BackButton
              SafeArea(
                child: Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(left: 5, top: 5),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(140),
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => Navigator.pop(context),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Positioned.fill(
            top: 320,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Text(
                      maxLines: 2,
                      poi.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    getInfoTextWithLeadingIcon(
                      poi.getDisplayAreaName(),
                      CountryFlag.fromCountryCode(
                        poi.countrycode ?? '',
                        theme: const ImageTheme(shape: Circle()),
                      ),
                    ),

                    getInfoTextWithLeadingIcon(
                      poi.category.name,
                      Icon(poi.category.icon),
                    ),

                    AddListDefaultButtons(
                      lists: allDefinedLists.where((l) => l.isDefault).toList(),
                      poi: poi,
                    ),

                    AddListCustomChips(
                      lists: allDefinedLists
                          .where((l) => !l.isDefault)
                          .toList(),
                      poi: poi,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getInfoTextWithLeadingIcon(String text, Widget leading) {
    return Row(
      spacing: 15,
      children: [
        SizedBox(width: 25, height: 25, child: Center(child: leading)),
        Text(
          text.toTitleCase(),
          style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
        ),
      ],
    );
  }
}
