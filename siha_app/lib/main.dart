import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

List<String> entries = <String>[];
List<String> uniqueEntries = <String>[];
List<String> time = <String>[];
List<String> uniqueTime = <String>[];
List<String> mealTime = <String>[];
List<String> uniqueMealTime = <String>[];
List<String> meals = <String>['Breakfast', 'Lunch', 'Dinner', 'Snack'];
List<String> foodPhotos = <String>[];
List<String> foodNames = <String>[];

final nutrition_app_id = '34b3b309';
final nutrition_app_key = '90be06c4d2e994fa3ef87d4106729004';

void main() {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIHA - System for Integrated Health Analytics',
      home: Home(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  _launchURL() async {
    const url = 'https://siha.qcri.org/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL_mail(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Image.asset(
          'images/logo.PNG',
          fit: BoxFit.cover,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
              width: double.infinity,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/user.png'),
            ),
            Text(
              'First Name',
              style: TextStyle(
                  fontFamily: 'San', fontSize: 20, color: Colors.blue[900]),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(40, 60, 40, 10),
              child: RaisedButton(
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About'),
                ),
                onPressed: _launchURL,
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 40,
              ),
              child: RaisedButton(
                child: ListTile(
                  leading: Icon(Icons.mail),
                  title: Text('Ask a question'),
                ),
                onPressed: () {
                  _launchURL_mail('gvvarma2712@gmail.com', 'Flutter Email Test',
                      'Hello Flutter');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodInput extends StatefulWidget {
  final String text;
  FoodInput([this.text]);

  @override
  _FoodInputState createState() => _FoodInputState();
}

class _FoodInputState extends State<FoodInput> {
  var _textController = TextEditingController();
  bool pressed = false;
  bool imagePressed = false;

  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";

  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();

  String _meal;

  void setMeal() {
    if (5 < _timeOfDay.hour && _timeOfDay.hour < 11) {
      _meal = meals[0];
    } else if (12 < _timeOfDay.hour && _timeOfDay.hour < 15) {
      _meal = meals[1];
    } else if (18 < _timeOfDay.hour && _timeOfDay.hour < 21) {
      _meal = meals[2];
    } else {
      _meal = meals[3];
    }
  }

  @override
  void initState() {
    super.initState();
    setMeal();
    initSpeechRecognizer();
  }

//  setState(() {
//  _textController.text = resultText;
//  });
  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() {
        resultText = speech;
      }),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(
        () {
          _isListening = false;
          _textController.text = resultText;
        },
      ),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  getData() async {
    foodPhotos = [];
    foodNames = [];
    http.Response response = await http.post(
      Uri.encodeFull('https://trackapi.nutritionix.com/v2/natural/nutrients'),
      headers: {
        'x-app-id': nutrition_app_id,
        'x-app-key': nutrition_app_key,
        'x-remote-user-id': '0'
      },
      body: {'query': '$_textController.text'},
    );
//    print(response.body);
    dynamic data = jsonDecode(response.body);
//    print(data['foods']);

    for (int i = 0; i < data['foods'].length; i++) {
      foodPhotos.add(data['foods'][i]['photo']['thumb']);
      foodNames.add(data['foods'][i]['food_name']);
    }
    return 'success - showing food';
  }

  @override
  Widget build(BuildContext context) {
    _textController.text = widget.text;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Image.asset(
          'images/logo.PNG',
          fit: BoxFit.cover,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                DateTime(
                  _dateTime.year,
                  _dateTime.month,
                  _dateTime.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ).toString(),
              ),
              RaisedButton(
                child: Text('Pick a Date and Time'),
                onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(minute: 0, hour: 0),
                  ).then(
                    (time) {
                      setState(
                        () {
                          if (time != null) {
                            _timeOfDay = time;
                            setMeal();
                          }
                        },
                      );
                    },
                  );
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  ).then(
                    (date) {
                      setState(
                        () {
                          if (date != null) {
                            _dateTime = date;
                          }
                        },
                      );
                    },
                  );
                },
              ),
              RaisedButton(
                child: Text(_meal),
                onPressed: () {
                  setState(() {
                    int index = meals.indexOf(_meal) + 1;
                    _meal = meals[index % 4];
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
//              ListTile(
//                title: TextField(
//                  controller: _textController,
//                ),
//              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: TextField(
                        controller: _textController,
                      ),
                    ),
                  ),
                  FlatButton(
                    shape: CircleBorder(),
                    child: Icon(
                      Icons.mic,
                      color: Colors.blue[800],
                    ),
                    onPressed: () {
                      if (_isAvailable && !_isListening)
                        _speechRecognition
                            .listen(locale: "en_US")
                            .then((result) => print('$result'));
                    },
                  ),
                ],
              ),
              ListTile(
                title: RaisedButton(
                  child: Text('Send'),
                  onPressed: () {
                    setState(
                      () {
                        pressed = true;
                        entries.insert(0, _textController.text);
                        time.insert(
                          0,
                          DateTime(
                            _dateTime.year,
                            _dateTime.month,
                            _dateTime.day,
                            _timeOfDay.hour,
                            _timeOfDay.minute,
                          ).toString(),
                        );
                        mealTime.insert(0, _meal);
                        if (!uniqueEntries.contains(_textController.text)) {
                          uniqueEntries.insert(0, _textController.text);
                          uniqueTime.insert(
                            0,
                            DateTime(
                              _dateTime.year,
                              _dateTime.month,
                              _dateTime.day,
                              _timeOfDay.hour,
                              _timeOfDay.minute,
                            ).toString(),
                          );
                          uniqueMealTime.insert(0, _meal);
                        }
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                child: Icon(Icons.image),
                onPressed: () {
                  getData().then(
                    (val) {
                      setState(
                        () {
                          print(val);
                          imagePressed = true;
                        },
                      );
                    },
                  );
                },
              ),
//              ListTile(
//                title: pressed ? Text(_textController.text) : SizedBox(),
//              ),
//              ListTile(
//                title: pressed
//                    ? Text(
//                        DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
//                                _timeOfDay.hour, _timeOfDay.minute)
//                            .toString(),
//                      )
//                    : SizedBox(),
//              ),
              Container(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                FloatingActionButton(
//                  heroTag: null,
//                  child: Icon(Icons.cancel),
//                  mini: true,
//                  backgroundColor: Colors.deepOrange,
//                  onPressed: () {
//                    if (_isListening)
//                      _speechRecognition.cancel().then(
//                            (result) => setState(() {
//                              _isListening = result;
//                              resultText = "";
//                            }),
//                          );
//                  },
//                ),
//                child: FlatButton(
//                  child: Icon(
//                    Icons.mic,
//                    color: Colors.blue[800],
//                  ),
//                  onPressed: () {
//                    if (_isAvailable && !_isListening)
//                      _speechRecognition
//                          .listen(locale: "en_US")
//                          .then((result) => print('$result'));
//                  },
//                ),
//                FloatingActionButton(
//                  heroTag: null,
//                  child: Icon(Icons.stop),
//                  mini: true,
//                  backgroundColor: Colors.deepPurple,
//                  onPressed: () {
//                    if (_isListening)
//                      _speechRecognition.stop().then(
//                            (result) => setState(() {
//                              _isListening = result;
//                            }),
//                          );
//                  },
//                ),
//              ],
                  ),
              imagePressed
                  ? ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: foodPhotos.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              foodPhotos[index],
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(foodNames[index]),
                          ],
                        );
                      },
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class FoodHistory extends StatefulWidget {
  @override
  _FoodHistoryState createState() => _FoodHistoryState();
}

class _FoodHistoryState extends State<FoodHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Image.asset(
          'images/logo.PNG',
          fit: BoxFit.cover,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: uniqueEntries.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: FlatButton(
              color: Colors.blue[300],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodInput(
                      uniqueEntries[index],
                    ),
                  ),
                );
              },
              child: Center(
                child: Text(
                  uniqueEntries[index],
                ),
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(uniqueTime[index]),
                    color: Colors.blue[200],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(uniqueMealTime[index]),
                    color: Colors.blue[100],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/guidelines.pdf');

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Image.asset(
          'images/logo.PNG',
          fit: BoxFit.cover,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: PDFViewer(document: document),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Image.asset(
          'images/logo.PNG',
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => (FoodInput())),
          );
        },
        tooltip: 'Add food eaten for the day',
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.blue[400],
        elevation: 3.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.room_service,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoodHistory()),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.explore,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiscoverPage()),
                );
              },
            ),
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.blue[900],
      ),
    );
  }
}
