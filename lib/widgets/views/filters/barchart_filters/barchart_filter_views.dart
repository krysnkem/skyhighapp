import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyhighapp/entities/for_sky_api/order_filter.dart';
import 'package:skyhighapp/utilities/capitalize.dart';

import '../../../../providers/barchart_data_provider.dart';
import '../../../../utilities/map_values.dart';
import '../../drop_down_filter_widget.dart';

class SegmentFilter extends StatelessWidget {
  const SegmentFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('SegmentFilter rebuilt');

    return DropDownFilterWidget<Segment>(
      value: context.select<BarChartDataProvider, Segment>(
          (provider) => provider.barSegmentValue),
      title: const Text("Segment"),
      icon: const Icon(Icons.segment),
      onChanged: context.read<BarChartDataProvider>().onChangedSegment,
      items: context
          .read<BarChartDataProvider>()
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



class RegionFilter extends StatelessWidget {
  const RegionFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('RegionFilter rebuilt');

    return DropDownFilterWidget<OrderRegion>(
      value: context.select<BarChartDataProvider, OrderRegion>(
          (provider) => provider.barRegionValue),
      title: const Text("Region"),
      icon: const Icon(Icons.public),
      onChanged: context.read<BarChartDataProvider>().onChanged,
      items: context
          .read<BarChartDataProvider>()
          .repository
          .regionValues
          .map<DropdownMenuItem<OrderRegion>>(
        (value) {
          return DropdownMenuItem<OrderRegion>(
            value: value,
            child: Text(value.name.capitalize()),
          );
        },
      ).toList(),
    );
  }
}


class SubCategoryFilter extends StatelessWidget {
  const SubCategoryFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('Subcategory rebuilt');

    return DropDownFilterWidget<SubCategory>(
      value: context.select<BarChartDataProvider, SubCategory>(
          (provider) => provider.barSubCategoryValue),
      icon: const Icon(Icons.category),
      title: const Text('Sub Category'),
      onChanged: context.read<BarChartDataProvider>().onChangedSubcategory,
      items: context
          .read<BarChartDataProvider>()
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

