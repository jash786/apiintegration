import 'package:apiintegration/internal/componets/appbars.dart';
import 'package:apiintegration/models/user.dart';
import 'package:apiintegration/services/remote_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User>? user;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    // fetch data from API
    getData();
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
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Visibility(
          visible: isLoaded,
          child: ListView.builder(
            itemCount: user?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(user![index].name.toString()),
                    subtitle: Text(user![index].email.toString()),
                  ),
                ),
              );
            },
          ),
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
