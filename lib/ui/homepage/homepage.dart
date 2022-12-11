import 'package:apiintegration/internal/componets/appbars.dart';
import 'package:apiintegration/internal/constants/colors.dart';
import 'package:apiintegration/models/user.dart';
import 'package:apiintegration/pushnotication.dart';
import 'package:apiintegration/services/remote_service.dart';
import 'package:apiintegration/ui/homepage/notificationpage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User>? user;
  var isLoaded = false;
  int count = 0;
  FirebaseNotification? firebase;
  hanldeAsync() async {
    await firebase?.initilize();
    Future<String?> token = firebase!.getToken();
    print("Firebase token : ${token}");
  }

  @override
  void initState() {
    super.initState();
    // fetch data from API
    getData();

    firebase = FirebaseNotification();
    firebase!.initilize();
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NotificationPage()),
          (route) => false);
    });
    hanldeAsync();
    // FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    //   print("message recieved");
    //   print(event.notification!.body);
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   print('Message clicked!');
    //   Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(builder: (context) => NotificationPage()),
    //       (route) => false);
    // });
  }

  Future getData() async {
    user = await RemoteService().getUsers();
    if (user != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: homeappbar,
        actions: [
          InkWell(
            child: const Icon(
              Icons.notifications,
              color: kwhite,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            },
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: user?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(user![index].name.toString()),
                    subtitle: Text(user![index].email.toString()),
                    leading: Text(user![index].id.toString()),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
