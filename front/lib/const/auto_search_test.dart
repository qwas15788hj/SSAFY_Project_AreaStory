import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class LocationSearch extends StatefulWidget {
  final onLocationSelected;
  final String? location;

  const LocationSearch({
    Key? key,
    required this.onLocationSelected,
    this.location,
  }) : super(key: key);

  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  String _selectedLocation = '서울특별시 서초구 역삼동';
  List<String>? _options;

  @override
  void initState() {
    super.initState();
    _loadOptions();
  }

  Future<void> _loadOptions() async {
    ByteData data = await rootBundle.load("asset/location/location.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    var options = <String>[];

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        var option = '${row[0]?.value} ${row[1]?.value} ${row[2]?.value}';

        options.add(option.toString());
      }
    }
    setState(() {
      _options = options;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_options == null) {
      return const CircularProgressIndicator();
    }
    return Container(
      constraints: BoxConstraints(maxWidth: 200.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xffefefef),
              ),
              child: Autocomplete<String>(
                initialValue: TextEditingValue(
                  text: _selectedLocation,
                ),
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  return _options!.where((String option) {
                    return option.contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  setState(() {
                    _selectedLocation = selection;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              if (_selectedLocation != null) {
                widget.onLocationSelected(_selectedLocation!);
              }
              _selectedLocation = '';
            },
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
