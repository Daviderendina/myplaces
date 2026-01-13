import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/components/common/page_subtitle.dart';
import 'package:myplaces/components/common/page_title.dart';
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

    Poi poi = widget.poi;
    poi.setImages(images.map(((i) => PoiImage(thumbnail: i))).toList());

    TextEditingController textEditingController = TextEditingController();

    if (poi.note.isNotEmpty) {
      textEditingController.text = poi.note;
    }

    List<MyList> allDefinedLists = ref.read(myListRepositoryProvider).getAll();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitle(text: poi.name, padding: EdgeInsetsGeometry.zero,),

              SizedBox(height: 12,),

              getInfoTextWithLeadingIcon(
                poi.getDisplayAreaName(),
                CountryFlag.fromCountryCode(
                  poi.countrycode ?? '',
                  theme: const ImageTheme(shape: Circle()),
                ),
              ),

              SizedBox(height: 10,),

              getInfoTextWithLeadingIcon(
                poi.category.name,
                Icon(poi.category.icon),
              ),

              SizedBox(height: 28),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                height: 200,
                color: Colors.grey.shade800,
                child: (poi.images.isEmpty)
                    ? Center(child: Icon(Icons.not_interested))
                    : CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    pageSnapping: true,
                    viewportFraction: 1.0,
                  ),
                  items: poi.images.map((poiImage) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.amber),
                          child: Image.network(
                            poiImage.thumbnail ?? "",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 40),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Aggiungi una nota..',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (newValue) =>
                      updatePoiNoteField(newValue, poi, ref),
                  onTapOutside: (event) {
                    updatePoiNoteField(
                      textEditingController.text,
                      poi,
                      ref,
                    );
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),

              SizedBox(height: 40),

              AddListDefaultButtons(
                lists: allDefinedLists.where((l) => l.isDefault).toList(),
                poi: poi,
              ),

              SizedBox(height: 30),

              PageSubtitle(text: "My lists"),

              SizedBox(height: 22),

              AddListCustomChips(
                lists: allDefinedLists.where((l) => !l.isDefault).toList(),
                poi: poi,
              ),
            ],
          ),
        ),
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
          style: TextStyle(color: Colors.grey.shade500, fontSize: 18),
        ),
      ],
    );
  }

  void updatePoiNoteField(String newValue, Poi poi, WidgetRef ref) {
    poi.note = newValue;
    ref.read(poiRepositoryProvider).save(poi);
  }
}
