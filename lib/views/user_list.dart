import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/providers/usersProvider.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Lista de Usuários')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // pushNamed = Coloca uma tela acima de outra (pop)
              Navigator.of(context).pushNamed(AppRoutes.USERFORM);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: usersProvider.count,
        itemBuilder: (ctx, i) => UserTile(usersProvider.byIndex(i)),
      ),
    );
  }
}
