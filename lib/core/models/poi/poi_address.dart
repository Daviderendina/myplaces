class PoiAddress {
  final String? houseNumber; // Numero civico
  final String? postcode; // Codice postale
  final String? street; // Via/strada
  final String? district; // Quartiere
  final String? city; // Città
  final String? county; // Provincia
  final String? state; // Regione
  final String? country; // Nazione
  final String? countryCode;

  PoiAddress({
    this.houseNumber,
    this.postcode,
    this.street,
    this.district,
    this.city,
    this.county,
    this.state,
    this.country,
    this.countryCode,
  });
}
