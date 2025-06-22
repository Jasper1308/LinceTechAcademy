import 'package:ap1/ep_provider/models/color_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/color_state.dart';
import '../models/video_model.dart';
import '../models/video_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _hashtagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final videoState = Provider.of<VideoState>(context, listen: false);
    final colorState = Provider.of<ColorState>(context, listen: false);
    return Scaffold(
      backgroundColor: colorState.backgroundColor.color,
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: colorState.appBarColor.color,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Text('URL do Video'),
            TextFormField(controller: _urlController),
            Text('Categorias #'),
            TextFormField(controller: _hashtagsController),
            ElevatedButton(
              onPressed: () async {
              videoState.addVideo(
                Video(url: _urlController.text, hashtags: _hashtagsController.text),
              );
              Navigator.pushNamed(context, '/');
              },
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
