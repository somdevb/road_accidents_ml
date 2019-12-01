import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool value1 = true;
  bool value2 = false;
  bool value3 = true;
  bool value4 = false;
  bool value5 = true;
  var hello;
  void onChangedValue1(bool value){
    setState(() {
      value1 = value;
    });
  }
  void onChangedValue2(bool value){
    setState(() {
      value2 = value;
    });
  }
  void onChangedValue3(bool value){
//    Future.delayed(const Duration(milliseconds: 8000), () {
      setState(() {
        value3 = value;
      });
//    });
  }
  void onChangedValue4(bool value){
    setState(() {
      value4 = value;
    });
  }
  void onChangedValue5(bool value){
    setState(() {
      value5 = value;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Location location = Location();

  Map<String, double> currentLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location.onLocationChanged().listen((value) {
      setState(() {
        currentLocation = value;
      });
    });
  }

  // Functions to URI/URL LAUNCHING
  TextEditingController _url = new TextEditingController();
  Future _openURL(String lat, String long) async{
    print('open click');
    var url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long'; //this is my own location
    hello = 'This is your location $lat N, $long E';
    //var url2 = 'https://www.google.com/maps/dir/Taj+Bengal+Kolkata,+Belvedere+Road,+Alipore,+Kolkata,+West+Bengal/Chandni+Chawk,+Bowbazar,+Kolkata,+West+Bengal/@22.5493968,88.3253622,14z/data=!3m1!4b1!4m14!4m13!1m5!1m1!1s0x3a027742c5766669:0xabaefc78ba555397!2m2!1d88.3344526!2d22.5376899!1m5!1m1!1s0x3a0277a9b548ba93:0x5afd1f3ef90c1479!2m2!1d88.3561094!2d22.5660637!3e0';
    //the above is the url for navigation details from a source to a destination
    if(await canLaunch(url))
      launch(url);
    else
      print('URL cannot be launched');
    return hello;
  }
  Future _launchURL(String toMailId, String subject, String body, String lat, String long) async {
    body = body + lat + ' N ' + long + ' E\nhttps://www.google.com/maps/search/?api=1&query=$lat,$long';
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future launchSMS(String tono, String body, String lat, String long) async {
    body = body + lat + " N " + long + " E\nhttps://www.google.com/maps/search/?api=1&query=$lat,$long";
    var url = 'sms:$tono?body=$body';
    // var url2 = 'https://www.google.com/maps/search/?api=1&query=52.32,4.917';
    if(await canLaunch(url)){
      launch(url);
    }
    else{
      print('COULD NOT LAUNCH $url');
    }
  }

  // user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Center(child: new Text("SMS Alert Sent!!!")),
          //content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D3542),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    width: 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ))
              ],
            ),
          ),
//        Switch(value: value1, onChanged: onChangedValue1),
          SizedBox(height: 20.0),

          SwitchListTile(value: value3, onChanged: onChangedValue3, activeColor: Colors.green, inactiveThumbColor: Colors.red, secondary: new Icon(Icons.directions_car, color: Colors.white, size: 50.0,),),
          SizedBox(height: 40.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('Sat',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0)),
                SizedBox(width: 1.5),
                Text('ark',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 35.0))
              ],
            ),
          ),
          SizedBox(height: 50.0),
          Container(
            height: MediaQuery.of(context).size.height - 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/back.jpg'),
                fit: BoxFit.cover,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 45.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height - 400.0,
                          child: new Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                                child: new InkWell(onTap: ()=> _showDialog(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              child: Row(
                                                  children: [
                                                    Hero(
                                                        tag: 'assets/plate1.png',
                                                        child: Image(
                                                            image: AssetImage('assets/plate1.png'),
                                                            fit: BoxFit.cover,
                                                            height: 40.0,
                                                            width: 40.0
                                                        )
                                                    ),
                                                    SizedBox(width: 10.0),
                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children:[
                                                          Text(
                                                              'Username : ',
                                                              style: TextStyle(
                                                                  fontFamily: 'Montserrat',
                                                                  color: Colors.white,
                                                                  fontSize: 17.0,
                                                                  fontWeight: FontWeight.bold
                                                              )
                                                          ),
                                                        ]
                                                    )
                                                  ]
                                              )
                                          ),
                                          Container(
                                              child: Row(
                                                  children: [
//                                                    Hero(
//                                                        tag: 'assets/plate1.png',
//                                                        child: Image(
//                                                            image: AssetImage('assets/plate1.png'),
//                                                            fit: BoxFit.cover,
//                                                            height: 40.0,
//                                                            width: 40.0
//                                                        )
//                                                    ),
                                                    SizedBox(width: 10.0),
                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children:[
                                                          Text(
                                                              'Rictor Bhowmick',
                                                              style: TextStyle(
                                                                  fontFamily: 'Montserrat',
                                                                  color: Colors.white,
                                                                  fontSize: 17.0,
                                                                  fontWeight: FontWeight.bold
                                                              )
                                                          ),
                                                        ]
                                                    )
                                                  ]
                                              )
                                          ),
                                            //IconButton(
//                                              icon: Icon(Icons.add),
//                                              color: Colors.white70,
//                                              onPressed: () {}
//                                          )
                                        ],
                                      )
                                ),

                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                                child: new InkWell(onTap: ()=> _launchURL('basusomdev100@gmail.com', 'EMERGENCY! ACCIDENT REPORTED BY RANGANATH', 'RANGANATH JUST HAD AN ACCIDENT AT THIS LOCATION:\n', currentLocation['latitude'].toString(), currentLocation['longitude'].toString()),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                            child: Row(
                                                children: [
                                                  Hero(
                                                      tag: 'assets/plate2.png',
                                                      child: Image(
                                                          image: AssetImage('assets/plate2.png'),
                                                          fit: BoxFit.cover,
                                                          height: 40.0,
                                                          width: 40.0
                                                      )
                                                  ),
                                                  SizedBox(width: 10.0),
                                                  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:[
                                                        Text(
                                                            'Mobile No. : ',
                                                            style: TextStyle(
                                                                fontFamily: 'Montserrat',
                                                                color: Colors.white,
                                                                fontSize: 17.0,
                                                                fontWeight: FontWeight.bold
                                                            )
                                                        ),
                                                      ]
                                                  ),
                                                  SizedBox(width: 62.0,),
                                                  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:[
                                                        Text(
                                                            '8444994443',
                                                            style: TextStyle(
                                                                fontFamily: 'Montserrat',
                                                                color: Colors.white,
                                                                fontSize: 17.0,
                                                                fontWeight: FontWeight.bold
                                                            )
                                                        ),
                                                      ]
                                                  ),
                                                ]
                                            )
                                        ),
                                      ],
                                    )
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                                child: new InkWell(onTap: ()=> _openURL(currentLocation['latitude'].toString(), currentLocation["longitude"].toString()),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                            child: Row(
                                                children: [
                                                  Hero(
                                                      tag: 'assets/plate3.png',
                                                      child: Image(
                                                          image: AssetImage('assets/plate3.png'),
                                                          fit: BoxFit.cover,
                                                          height: 40.0,
                                                          width: 40.0
                                                      )
                                                  ),
                                                  SizedBox(width: 10.0),
                                                  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:[
                                                        Text(
                                                            'Vehicle Number : ',
                                                            style: TextStyle(
                                                                fontFamily: 'Montserrat',
                                                                color: Colors.white,
                                                                fontSize: 17.0,
                                                                fontWeight: FontWeight.bold
                                                            )
                                                        ),
                                                      ]
                                                  ),
                                                  SizedBox(width: 19.0,),
                                                  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:[
                                                        Text(
                                                            'WB 06CR 4582',
                                                            style: TextStyle(
                                                                fontFamily: 'Montserrat',
                                                                color: Colors.white,
                                                                fontSize: 17.0,
                                                                fontWeight: FontWeight.bold
                                                            )
                                                        ),
                                                      ]
                                                  ),
                                                ]
                                            ),
                                        ),
                                      ]),
                              ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0),
                                child: new InkWell(onTap: ()=> _openURL(currentLocation['latitude'].toString(), currentLocation["longitude"].toString()),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                              children: [
                                                Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children:[
                                                      Text(
                                                          'Current Location: 23.2679701N 77.3692089E',
                                                          style: TextStyle(
                                                              fontFamily: 'Montserrat',
                                                              color: Colors.white,
                                                              fontSize: 17.0,
                                                              fontWeight: FontWeight.bold
                                                          )
                                                      ),
                                                    ]
                                                ),
                                              ]
                                          ),
                                        ),
                                      ]),
                                ),
                              ),

                              SizedBox(height: 100.0,),
                              RaisedButton(
                                onPressed: () => launchSMS('+917980471404','ACCIDENT REPORTED BY RANGANATH AT ', currentLocation["latitude"].toString(), currentLocation["longitude"].toString()) ,
                                color: Colors.red,
                                disabledColor: Colors.blue,
                                child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                ),
                              ),
                            ],
                        ))),

                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 65.0,
                      width: 180.0,
                      child: Center(
                          child: Center(
                            child: Text('2019 \u00a9 Somdev Basu',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15.0)),
                          )),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      key: _scaffoldKey,
      appBar: new AppBar(
//        actions: <Widget>[
//
//
//          ), Switch
//          SwitchListTile(value: value3, onChanged: onChangedValue3, activeColor: Colors.green, inactiveThumbColor: Colors.red, secondary: new Icon(Icons.directions_bike))
//        ],
//        SwitchListTile(value: value3, onChanged: onChangedValue3, activeColor: Colors.green, inactiveThumbColor: Colors.red, secondary: new Icon(Icons.directions_bus))
//        SwitchListTile(value:value3, onChanged: onChangedValue3, activeColor: Colors.green, inactiveThumbColor: Colors.red, secondary: new Icon(Icons.directions_car))
        leading: new IconButton(icon: new Icon(Icons.menu), onPressed: () => _scaffoldKey.currentState.openDrawer(),),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
        )
      , child: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(40), bottomRight: Radius.circular(40)),
        child: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Row(
                  children: <Widget>[
                    Text('Sat',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0)),
                    SizedBox(width: 1.5),
                    Text('ark',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontSize: 25.0))
                  ],
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/back.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(75.0)),
                ),
              ),
              ListTile(
                title: Text('Reporting required', style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 17.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.normal
                  )
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Response needed', style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 17.0,
                  color: Colors.white70,
                  fontWeight: FontWeight.normal,
                ),),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
