import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '/custom_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {
  var temperature = '36';
  String selected = '';
  TextEditingController controller =TextEditingController();

  void _listenToSensorDataChanges() {
    final DatabaseReference sensorDataRef1 =
    FirebaseDatabase.instance.ref().child('/ABC Company/sensor/env_temp');
    sensorDataRef1.onValue.listen((value) {
      print(value.snapshot.value);
      temperature = value.snapshot.value.toString();
      setState(() {

      });
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listenToSensorDataChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: AlignmentDirectional.center,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/logo.jpg",
                    width: 200,
                    height: 150,
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Home"),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  // const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {

                      },
                      child: const Text("Logout"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white60,
                        foregroundColor: Colors.black,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextField(
                                  controller :controller,
                                  onSelected: (data) {
                                    setState(() {
                                      print("${selected}/heart");
                                      selected = data.empName;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    selected ='';
                                    controller.clear();
                                    setState(() {

                                    });
                                  },
                                  child: const Icon(Icons.clear),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white60,
                                    foregroundColor: Colors.black,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          (selected.isNotEmpty)
                              ? Row(
                                  children: [
                                    CustomOptions(
                                      assetsPath: "assets/icons/oxy.svg",
                                      dataValue: "$selected/oxy",
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomOptions(
                                      assetsPath:
                                          "assets/icons/heart-pulse-solid.svg",
                                      dataValue: "$selected/heart",
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomOptions(
                                      assetsPath: "assets/icons/temp.svg",
                                      dataValue: "${selected.trim()}/temp",
                                    ),
                                  ],
                                )
                              : Center(child: Text("Select the employee"),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(23)),
                                  color: Colors.white,
                                  child: const SizedBox(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                                      child: Text(
                                        "Enviroment",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  width: 200,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.thermostat,size: 60,),
                                        Text(
                                          "$temperature °C",
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(23)),
                                  color: Colors.white,
                                  child: SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Notification",
                                            style: TextStyle(fontSize: 25),
                                          ),
                                          Icon(Icons.notifications)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Container(
                                    width: 200,
                                    height: 140,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: CustomUserList())
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void changeSelected(Employee data) {
    selected = data.empName;
    setState(() {
      print(selected);
    });
  }
}
