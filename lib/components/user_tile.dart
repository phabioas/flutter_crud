import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/providers/usersProvider.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.toString().isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl.toString()));

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.USERFORM, arguments: user);
                },
                icon: new Icon(
                  Icons.edit,
                  color: Colors.orange,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Excluir Usuário'),
                      content: Text('Tem certeza?'),
                      actions: <Widget>[
                        ElevatedButton.icon(
                          label: Text('Não'),
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                        ),
                        ElevatedButton.icon(
                          label: Text('Sim'),
                          icon: Icon(Icons.check),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                        ),
                      ],
                    ),
                  ).then((value) {
                    if (value) {
                      Provider.of<UsersProvider>(context, listen: false)
                          .remove(user);
                    }
                  });
                },
                icon: new Icon(Icons.delete, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
