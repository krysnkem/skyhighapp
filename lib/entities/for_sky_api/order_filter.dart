class OrderFilter {
  String? year;
  Segment? segment;
  OrderRegion? region;
  ShipMode? shipMode;
  SubCategory? subCategory;
  String? city;
  String? month;

  OrderFilter({
    this.year,
    this.month,
    this.segment,
    this.region,
    this.shipMode,
    this.subCategory,
    this.city,
  });

  OrderFilter copyWith({
    String? year,
    Segment? segment,
    OrderRegion? region,
    ShipMode? shipMode,
    SubCategory? subCategory,
    String? city,
    String? month,
  }) {
    return OrderFilter(
      year: year ?? this.year,
      segment: segment ?? this.segment,
      region: region ?? this.region,
      shipMode: shipMode ?? this.shipMode,
      subCategory: subCategory ?? this.subCategory,
      city: city ?? this.city,
      month: month ?? this.month,
    );
  }
}

enum OrderRegion {
  all,
  central,
  east,
  west,
  south,
}

enum ShipMode {
  all,
  firstClass,
  sameDay,
  standardClass,
  secondClass,
}

enum SubCategory {
  all,
  accessories,
  appliances,
  art,
  binders,
  bookcases,
  chairs,
  copiers,
  envelopes,
  fasteners,
  furnishings,
  labels,
  machines,
  paper,
  phones,
  storage,
  supplies,
  tables,
}

enum Segment {
  all,
  consumer,
  corporate,
  homeOffice,
}
