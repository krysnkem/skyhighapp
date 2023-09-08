import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyhighapp/providers/piechart_data_provider.dart';
import 'package:skyhighapp/utilities/capitalize.dart';

import '../../../../entities/for_sky_api/order_filter.dart';
import '../../../../utilities/map_values.dart';
import '../../drop_down_filter_widget.dart';

class SegmentFilterForRegion extends StatelessWidget {
  const SegmentFilterForRegion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return DropDownFilterWidget<Segment>(
      value: context.select<PieChartDataProvider, Segment>(
          (provider) => provider.pieSegmentValue),
      title: const Text("Segment"),
      icon: const Icon(Icons.segment),
      onChanged: context.read<PieChartDataProvider>().onChangedSegment,
      items: context
          .read<PieChartDataProvider>()
          .repository
          .segmentValues
          .map<DropdownMenuItem<Segment>>((value) {
        final text = OrderMapValues.segementValues[value];
        return DropdownMenuItem<Segment>(
          value: value,
          child: Text(text!),
        );
      }).toList(),
    );
  }
}



class SubCategoryFilterForRegion extends StatelessWidget {
  const SubCategoryFilterForRegion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return DropDownFilterWidget<SubCategory>(
      value: context.select<PieChartDataProvider, SubCategory>(
          (provider) => provider.pieSubCategoryValue),
      icon: const Icon(Icons.category),
      title: const Text('Sub Category'),
      onChanged: context.read<PieChartDataProvider>().onChangedSubcategory,
      items: context
          .read<PieChartDataProvider>()
          .repository
          .subCategoryValues
          .map<DropdownMenuItem<SubCategory>>(
        (value) {
          return DropdownMenuItem<SubCategory>(
            value: value,
            child: Text(value.name.capitalize()),
          );
        },
      ).toList(),
    );
  }
}