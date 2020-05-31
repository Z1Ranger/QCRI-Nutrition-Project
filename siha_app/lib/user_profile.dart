import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants.dart';

class ProfilePage extends StatelessWidget {
  _launchURL() async {
    const url = 'https://siha.qcri.org/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchMail(String toMailId, String subject, String body) async {
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
        backgroundColor: kMainThemeColor,
        title: FlatButton(
          child: Image.asset(
            kAppBarLogo,
            height: 100,
            width: 100,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: kMainThemeColor,
                height: 80,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 40),
                decoration: BoxDecoration(
                  color: kMainThemeColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(75),
                    bottomRight: Radius.circular(75),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 100,
                    ),
                    Text(
                      'First Name',
                      style: TextStyle(
                        fontFamily: 'San',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kMainThemeColor,
                    ),
                    margin: EdgeInsets.fromLTRB(40, 60, 40, 20),
                    child: FlatButton(
                      child: ListTile(
                        leading: Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                        title: Text(
                          'About',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: _launchURL,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kMainThemeColor,
                    ),
                    margin: EdgeInsets.fromLTRB(40, 10, 40, 20),
                    child: FlatButton(
                      child: ListTile(
                        leading: Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Ask a question',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        _launchMail(kEmail, 'Enquiry', 'Hi,');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
