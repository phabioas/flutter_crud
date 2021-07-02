import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/providers/usersProvider.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void loadFormaData(User? user) {
    if (user != null) {
      _formData['id'] = user.id.toString();
      _formData['name'] = user.name.toString();
      _formData['email'] = user.email.toString();
      _formData['avatarUrl'] = user.avatarUrl.toString();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadFormaData(ModalRoute.of(context)?.settings.arguments as User?);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Formulário de Usuário'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final isValid = _form.currentState!.validate();

                if (isValid) {
                  _form.currentState?.save();
                  Provider.of<UsersProvider>(context, listen: false).put(User(
                      id: _formData['id'],
                      name: _formData['name'].toString(),
                      email: _formData['email'].toString(),
                      avatarUrl: _formData['avatarUrl']));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _form,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nome'),
                    initialValue: _formData['name'],
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe um nome';
                      }

                      if (value.trim().length < 3) {
                        return 'O nome deve ter pelo menos 3 caracteres';
                      }

                      return null;
                    },
                    onSaved: (value) => _formData['name'] = value.toString(),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    initialValue: _formData['email'],
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe um Email';
                      }

                      if (value.trim().length < 10) {
                        return 'O email deve ter pelo menos 10 caracteres';
                      }

                      return null;
                    },
                    onSaved: (value) => _formData['email'] = value.toString(),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'URL do Avatar'),
                    initialValue: _formData['avatarUrl'],
                    onSaved: (value) =>
                        _formData['avatarUrl'] = value.toString(),
                  ),
                ],
              ),
            )));
  }
}
