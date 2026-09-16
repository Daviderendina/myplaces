class PoiSearchResult {
  final String id;
  final String name;
  final String positionLabel;
  final String osmType;

  PoiSearchResult(
    this.id,
    this.name,
    this.positionLabel, {
    this.osmType = '',
  });
}
