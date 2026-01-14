import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/components/common/my_subtitle.dart';
import 'package:myplaces/components/common/my_title.dart';
import 'package:myplaces/components/common/note_box.dart';
import 'package:myplaces/extension/title_case_extension.dart';
import 'package:myplaces/repository/poi_repository.dart';

import '../components/common/poi_detail/add_list_custom.dart';
import '../components/common/poi_detail/add_list_default.dart';
import '../functions/select_list_page/select_list_page.dart';
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

    List<MyList> defaultLists = ref
        .read(myListRepositoryProvider)
        .getAllDefaultLists();

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 420,
            child: Image.network(
              'https://media.istockphoto.com/id/635758088/photo/sunrise-at-the-eiffel-tower-in-paris-along-the-seine.jpg?s=612x612&w=0&k=20&c=rdy3aU1CDyh66mPyR5AAc1yJ0yEameR_v2vOXp2uuMM=',
              fit: BoxFit.cover,
            ),
          ),

          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Container(
              //height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    MyTitle(text: poi.name),

                    SizedBox(height: 12),

                    getInfoTextWithLeadingIcon(
                      poi.getDisplayAreaName(),
                      CountryFlag.fromCountryCode(
                        poi.countrycode ?? '',
                        theme: const ImageTheme(shape: Circle()),
                      ),
                    ),

                    SizedBox(height: 10),

                    getInfoTextWithLeadingIcon(
                      poi.category.name,
                      Icon(poi.category.icon),
                    ),

                    SizedBox(height: 28),

                    Text(
                      maxLines: 4,
                      "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi conLorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi con",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                      ),
                    ),

                    SizedBox(height: 30),

                    MySubtitle(text: "My notes"),
                    SizedBox(height: 12),

                    NoteBox(
                      actualNote: poi.note,
                      onSubmitted: (value) =>
                          updatePoiNoteField(value, poi, ref),
                    ),
                    SizedBox(height: 24),

                    // Buttons list
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...defaultLists.map((list) {
                          return IconButton(
                            onPressed: () => triggerPoiToList(poi, list),
                            icon: Icon(
                              Icons.question_mark_outlined,
                              size: 30,
                              color: poi.belongToList(list.id)
                                  ? Colors.amber
                                  : Colors.grey,
                            ),
                          );
                        }),
                        SizedBox(width: 15),
                        ActionChip(
                          backgroundColor: Colors.lightBlue.withAlpha(30),
                          onPressed: () {
                            ref.read(selectedPoiProvider.notifier).state = poi;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SelectListPage(),
                              ),
                            );
                          },
                          label: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Add to list",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.lightBlue.shade200,
                              ),
                            ),
                          ),
                          avatar: Icon(
                            Icons.add,
                            color: Colors.lightBlue.shade200,
                          ),
                          elevation: 0,
                          pressElevation: 0,
                          shape: const StadiumBorder(
                            side: BorderSide(color: Colors.transparent),
                          ),
                          padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 40,
            left: 15,
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.black54, // colore del cerchio
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  customBorder: CircleBorder(),
                  onTap: () => Navigator.pop(context),
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
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
        SizedBox(width: 22, height: 22, child: Center(child: leading)),
        Text(
          text.toTitleCase(),
          style: TextStyle(color: Colors.grey.shade500, fontSize: 18),
        ),
      ],
    );
  }

  void triggerPoiToList(Poi poi, MyList myList) {
    PoiRepository repository = ref.read(poiRepositoryProvider);
    repository.togglePoiInList(poi, myList);
    ref.read(savedPageProvider.notifier).refresh();
  }

  void updatePoiNoteField(String newValue, Poi poi, WidgetRef ref) {
    poi.note = newValue;
    ref.read(poiRepositoryProvider).save(poi);
    // TODO serve un provider anche per la pagina myLisy che viene quindi aggiornata da questa!!! Altrimenti non si aggiornala schermata
    ref.read(savedPageProvider.notifier).refresh();
  }
}
