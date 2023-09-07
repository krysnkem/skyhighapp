import 'package:skyhighapp/entities/for_sky_api/order_filter.dart';

class OrderMapValues {
  static const shipModeValues = <ShipMode, String>{
    ShipMode.firstClass: "First Class",
    ShipMode.standardClass: "Standard Class",
    ShipMode.secondClass: "Second Class",
    ShipMode.sameDay: "Same Day",
    ShipMode.all: "All",
  };
  static const segementValues = <Segment, String>{
    Segment.consumer: "Consumer",
    Segment.corporate: "Corporate",
    Segment.homeOffice: "Home Office",
    Segment.all: "All",
  };
}
