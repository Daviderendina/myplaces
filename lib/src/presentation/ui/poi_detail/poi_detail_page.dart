import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/components/common/my_subtitle.dart';
import 'package:myplaces/components/common/my_title.dart';
import 'package:myplaces/components/common/note_box.dart';
import 'package:myplaces/extension/title_case_extension.dart';
import 'package:myplaces/repository/poi_repository.dart';
import 'package:myplaces/src/presentation/ui/common/poi/poi_button_list.dart';

import '../../../../functions/select_list_page/select_list_page.dart';
import '../../../../models/my_list.dart';
import '../../../../models/poi.dart';
import '../../../../models/poi_image.dart';
import '../../../../providers.dart';

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

    final List<MyList> allDefinedLists = ref.watch(myListsProvider);
    final poi = ref.watch(selectedPoiProvider);

    if (poi == null) return SizedBox();

    poi.setImages(images.map(((i) => PoiImage(thumbnail: i))).toList());

    List<MyList> defaultLists = allDefinedLists
        .where((l) => l.isDefault)
        .toList();

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
                    PoiButtonList(),
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

  void updatePoiNoteField(String newValue, Poi poi, WidgetRef ref) {
    poi.note = newValue;
    ref.read(poiRepositoryProvider).save(poi);
    // TODO serve un provider anche per la pagina myLisy che viene quindi aggiornata da questa!!! Altrimenti non si aggiornala schermata
    ref.read(listsControllerProvider.notifier).refresh();
  }
}
