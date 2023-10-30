import 'package:flutter/material.dart';
import 'package:pertemuan5/api_data_source.dart';
import 'package:pertemuan5/users_model.dart';

class Halamanusers extends StatelessWidget {
  const Halamanusers({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List User'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueGrey],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.loadUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error bro'),
            );
          }
          if (snapshot.hasData) {
            Users users = Users.fromJson(snapshot.data!);
            return ListView.builder(
              itemCount: users.data!.length,
              itemBuilder: (context, index) {
                var usr = users.data![index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 3,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    tileColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UserDetail(
                              user: usr,
                              idUser: usr.id!,
                            );
                          },
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blueGrey,
                      foregroundImage: NetworkImage(usr.avatar!),
                    ),
                    title: Text(
                      "${usr.firstName!} ${usr.lastName!}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      usr.email!,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class UserDetail extends StatelessWidget {
  final Data user;
  final int idUser;

  const UserDetail({Key? key, required this.user, required this.idUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User ${idUser.toString()}'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueGrey],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10), 
                child: CircleAvatar(
                  foregroundImage: NetworkImage(user.avatar!),
                  radius: 70,
                  backgroundColor: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "${user.firstName!} ${user.lastName!}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                user.email!,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

