import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

List<String> entries = <String>[];
List<String> uniqueEntries = <String>[];
List<String> time = <String>[];
List<String> uniqueTime = <String>[];

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

  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";

  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
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
                        }
                      },
                    );
                  },
                );
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
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
            ListTile(
              title: TextField(
                controller: _textController,
              ),
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
                      if (!uniqueEntries.contains(_textController.text)) {
                        uniqueEntries.insert(0, _textController.text);
                        uniqueTime.insert(
                          0,
                          DateTime(
                                  _dateTime.year,
                                  _dateTime.month,
                                  _dateTime.day,
                                  _timeOfDay.hour,
                                  _timeOfDay.minute)
                              .toString(),
                        );
//                      _dateTime.toString()
                      }
                    },
                  );
//                  var route = MaterialPageRoute(
//                    builder: (context) =>
//                        (FoodHistory(value: _textController.text)),
//                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: pressed ? Text(_textController.text) : SizedBox(),
            ),
            ListTile(
              title: pressed
                  ? Text(
                      DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
                              _timeOfDay.hour, _timeOfDay.minute)
                          .toString(),
                    )
                  : SizedBox(),
            ),
            SizedBox(
              height: 10,
            ),
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
              child: FloatingActionButton(
                child: Icon(Icons.mic),
                onPressed: () {
                  if (_isAvailable && !_isListening)
                    _speechRecognition
                        .listen(locale: "en_US")
                        .then((result) => print('$result'));
                },
                backgroundColor: Colors.blue[400],
              ),
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
          ],
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
              color: Colors.blue[200],
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
            subtitle: Container(
              child: Text(uniqueTime[index]),
              color: Colors.blue[300],
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
//        floatingActionButton: UnicornDialer(
//          parentButtonBackground: Colors.blue[400],
//          orientation: UnicornOrientation.VERTICAL,
//          parentButton: Icon(Icons.add),
//          childButtons: _getProfileMenu(),
//        ),
//        floatingActionButton: SpeedDial(
//          animatedIcon: AnimatedIcons.menu_home,
//          children: [
//            SpeedDialChild(
//              child: Icon(Icons.ac_unit),
//              label: 'First item',
//              onTap: () {},
//            ),
//          ],
//        ),
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
                }),
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
