import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomOptions extends StatefulWidget {
  String assetsPath;
  String dataValue;
  CustomOptions({Key? key, required this.assetsPath, required this.dataValue})
      : super(key: key);

  @override
  State<CustomOptions> createState() => _CustomOptionsState();
}

class _CustomOptionsState extends State<CustomOptions> {
  String dataValue = '0';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listenToSensorDataChanges();
  }

  void _listenToSensorDataChanges() {
    print(widget.dataValue);
    final DatabaseReference sensorDataRef1 = FirebaseDatabase.instance
        .ref()
        .child('/ABC Company/sensor/${widget.dataValue}');
    sensorDataRef1.onChildAdded.listen((event) {
      dataValue = event.snapshot.value as String;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 250,
          height: 200,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  widget.assetsPath,
                  width: 80,
                ),
                SizedBox(height: 20),
                Text(
                  "Value : $dataValue",
                  style: TextStyle(
                      fontSize: 20,
                      color: (int.parse(dataValue) < 40)
                          ? Colors.red
                          : Colors.black),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        CustomLineCharts(
          path: widget.dataValue,
        ),
      ],
    );
  }
}

class CustomLineCharts extends StatefulWidget {
  String path;
  CustomLineCharts({Key? key, required this.path}) : super(key: key);

  @override
  State<CustomLineCharts> createState() => _CustomLineChartsState();
}

class SensorData {
  final double value;
  final DateTime timestamp;

  SensorData(this.value, this.timestamp);
}

class _CustomLineChartsState extends State<CustomLineCharts> {
  List<SensorData> sensorDataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listenToSensorDataChanges();
  }

  void _listenToSensorDataChanges() {
    final DatabaseReference sensorDataRef1 = FirebaseDatabase.instance
        .ref()
        .child('/ABC Company/sensor/${widget.path}');
    sensorDataRef1.onChildAdded.listen((event) {
      String timeValue = event.snapshot.key.toString().split('_')[1];
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(timeValue));
      sensorDataList.add(
          SensorData(double.parse(event.snapshot.value.toString()), dateTime));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final seriesList = [
      charts.Series<SensorData, DateTime>(
        id: 'Sensor Values',
        data: sensorDataList,
        measureLowerBoundFn: (datum, index) => datum.value,
        domainFn: (SensorData data, _) => data.timestamp,
        measureFn: (SensorData data, _) => data.value,
      ),
    ];
    return Container(
      height: 200,
      width: 250,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: charts.TimeSeriesChart(seriesList,
          animate: true,
          primaryMeasureAxis: charts.NumericAxisSpec(
            tickProviderSpec: charts.StaticNumericTickProviderSpec(
              <charts.TickSpec<num>>[
                charts.TickSpec<num>(80),
                charts.TickSpec<num>(85),
                charts.TickSpec<num>(90),
                charts.TickSpec<num>(95),
                charts.TickSpec<num>(100),
              ],
            ),
          )
          // Add any additional chart configurations here
          ),
    );
  }
}

class LinearSales {
  final int time;
  final int level;

  LinearSales(this.time, this.level);
}

class Employee {
  final String empName;
  final String empPosition;
  final String key;

  Employee(
      {required this.key, required this.empName, required this.empPosition});
}

class CustomTextField extends StatefulWidget {
  final Function(Employee)?onSelected;
  final TextEditingController controller;// Callback function to handle suggestion selection

  CustomTextField({Key? key, this.onSelected,required this.controller}) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  List<String> suggestions = [];
  final DatabaseReference _employeeRef =
      FirebaseDatabase.instance.ref("/ABC Company").child('emp_info');
  Employee? selectedSuggestion;
  List<Employee> employees = [];

  Future<void> _retrieveEmployeeList() async {
    _employeeRef.once().then((value) {
      Map<String, dynamic> firebaseResponse =
          value.snapshot.value as Map<String, dynamic>;

      firebaseResponse.forEach((key, value) {
        String empName = value['emp_code'];
        String empPosition = value['emp_position'];
        Employee employee =
            Employee(key: empName, empName: key, empPosition: empPosition);
        employees.add(employee);
      });
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveEmployeeList();
  }

  void _onSuggestionSelected(Employee suggestion) {
    setState(() {
      selectedSuggestion = suggestion;
    });

    // Call the onSelected callback function if provided
    if (widget.onSelected != null) {
      widget.onSelected!(suggestion);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 800,
      child: TypeAheadField<Employee>(
        itemBuilder: (context, sone) {
          return ListTile(
            title: Text(sone.empName.toString()),
          );
        },
        onSuggestionSelected: (suggestion) {
          _onSuggestionSelected(suggestion);
          widget.controller.text = suggestion.empName.toString();
          print(suggestion.empName);
        },
        suggestionsCallback: (pattern) {
          List<Employee> matches = <Employee>[];
          matches.addAll(employees);

          matches.retainWhere((s) {
            return s.empName.toLowerCase().contains(pattern.toLowerCase());
          });
          return matches;
        },
        textFieldConfiguration: TextFieldConfiguration(
          controller: widget.controller,
          style: const TextStyle(
            fontSize: 17,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            filled: true,
            fillColor: Colors.white,
            labelText: 'Search Employee Name',
            labelStyle: const TextStyle(fontSize: 16),
            suffix: SizedBox(
                child: TextButton(
              onPressed: () {},
              child: const Text(
                'Search',
                style: TextStyle(fontSize: 18),
              ),
            )),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            prefixIcon: const Icon(
              Icons.search,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomUserList extends StatefulWidget {
  const CustomUserList({Key? key}) : super(key: key);

  @override
  State<CustomUserList> createState() => _CustomUserListState();
}

class _CustomUserListState extends State<CustomUserList> {
  final List<User> users = [];
  Map<String, dynamic> data = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveEmployeeList();
  }

  List<Employee> employees = [];

  Future<void> _retrieveEmployeeList() async {
    final DatabaseReference _employeeRef =
        FirebaseDatabase.instance.ref("/ABC Company").child('emp_info');
    _employeeRef.once().then((value) {
      Map<String, dynamic> firebaseResponse =
          value.snapshot.value as Map<String, dynamic>;

      firebaseResponse.forEach((key, value) {
        String empName = value['emp_code'];
        String empPosition = value['emp_position'];
        Employee employee =
            Employee(key: empName, empName: key, empPosition: empPosition);
        employees.add(employee);
      });
      _listenToSensorDataChanges();
    });
  }

  void _listenToSensorDataChanges() {
    print(employees);
    for (final i in employees) {
      final DatabaseReference sensorDataRef1 = FirebaseDatabase.instance
          .ref()
          .child('/ABC Company/sensor/${i.empName}');
      sensorDataRef1.once().then((value) {
        // print(value.snapshot.value);
        var temp = value.snapshot.value;
        data = value.snapshot.value as Map<String, dynamic>;
        users
            .add(User(i.empName, i.empPosition, getLatestValue(data['heart'])));
        users.add(User(i.empName, i.empPosition, getLatestValue(data['oxy'])));
        users.add(User(i.empName, i.empPosition, getLatestValue(data['temp'])));
      });
    }
  }

  dynamic getLatestValue(Map<String, dynamic> values) {
    final sortedKeys = values.keys.toList()..sort((a, b) => b.compareTo(a));
    final latestKey = sortedKeys.first;
    final latestValue = values[latestKey];

    if (values.containsKey(latestKey)) {
      final parsedValue = int.tryParse(latestValue);
      print(parsedValue);
      if (values == data['heart'] &&
          (parsedValue == null || parsedValue < 60 || parsedValue > 100)) {
        return 'Heart';
      } else if (values == data['oxy'] &&
          (parsedValue == null || parsedValue < 95)) {
        return 'Oxy';
      } else if (values == data['temp'] &&
          (parsedValue == null || parsedValue < 37 || parsedValue > 38)) {
        return 'Temp';
      } else {
        return latestValue;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        if (user.type.isNotEmpty) {
          return ListTile(
            title: Text(user.name),
            subtitle: Text('Value: ${user.type}'),
          );
        } else {
          return SizedBox.shrink(); // Skip rendering if value >= 32
        }
      },
    );
  }
}

class User {
  final String name;
  final String value;
  final String type;

  User(this.name, this.value, this.type);
}
