import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:instrument_directory/theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class OtherPage extends StatelessWidget {
  @override
  //OtherPage({Key key}) : super(key: key);

  //お問い合わせ
  String attachment;

  final _recipientController = TextEditingController(
    text: 'makitaba001.info@gmail.com',
  );

  final _subjectController = TextEditingController(text: '[My楽器ノート]お問い合わせ');

  final _bodyController = TextEditingController(
    text: '----------\n件名を変えずにご送信お願いします。\n----------',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  //開発者のTwitter
  _launchInTwitter() async {
    const url = 'https://twitter.com/hibiki_makitaba';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,//iOSでアプリ内かブラウザのどちらかでURLを開くか決める。
        forceWebView: false,//Androidでアプリ内かブラウザのどちらかでURLを開くか決める。
        universalLinksOnly: true,
      );
    }
    else {
      throw 'このTwitterアカウントは存在しません';
    }
  }

  //開発者のinstagram
  _launchInInstagram() async {
    const url = 'https://www.instagram.com/iiyotu1142';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,//iOSでアプリ内かブラウザのどちらかでURLを開くか決める。
        forceWebView: false,//Androidでアプリ内かブラウザのどちらかでURLを開くか決める。
        universalLinksOnly: true,
      );
    }
    else {
      throw 'このTwitterアカウントは存在しません';
    }
  }

  @override
  Widget build(BuildContext context) {
    //final theme = Provider.of<AppTheme>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('メニュー'),
      ),
      body: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Divider(
              thickness: 1.0,
            ),
            Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => ListTile(
                leading: Icon(Icons.lightbulb),
                title: Text('ダークモード'),
                trailing: Switch.adaptive(
                  //value: notifier.darkTheme,
                  onChanged: (val) {
                    notifier.toggleTheme();
                  },
                  value: notifier.darkTheme,
                ),
              ),
            ),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text('お問い合わせ'),
              trailing: Text('ご意見・ご要望など'),
              onTap: send,
            ),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
              leading: Icon(MaterialCommunityIcons.twitter),
              title: Text('開発者（Twitter）'),
              onTap: () {
                _launchInTwitter();
              }
            ),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
              leading: Icon(MaterialCommunityIcons.instagram),
              title: Text('開発者（Instagram）'),
              onTap: () {
                _launchInInstagram();
              },
            ),
            Divider(
              thickness: 1.0,
            ),
            new ListTile(
              leading: Icon(Icons.star),
              title: const Text('評価'),
              onTap: () {
               AppReview.requestReview.then((context) {});
              },
            ),
            Divider(
              thickness: 1.0,
            ),
            ListTile(),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
              title: Text('利用規約'),
              onTap: () {},
            ),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
              title: Text('プライバシーポリシー'),
              onTap: () {},
            ),
            Divider(
              thickness: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}