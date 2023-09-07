import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/barchart_data_provider.dart';
import '../drop_down_filter_widget.dart';

class YearFilter extends StatelessWidget {
  const YearFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('YearFilter rebuilt');
    return DropDownFilterWidget<String>(
      value: context
          .select<BarChartDataProvider, String>((provider) => provider.year),
      onChanged: context.read<BarChartDataProvider>().onChangedYear,
      items: context
          .read<BarChartDataProvider>()
          .repository
          .years
          .map<DropdownMenuItem<String>>(
        (value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          );
        },
      ).toList(),
    );
  }
}