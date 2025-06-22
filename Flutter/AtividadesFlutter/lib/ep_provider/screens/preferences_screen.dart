import 'package:ap1/ep_provider/models/color_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/color_state.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  Cores _appbarcolor = Cores.blue;
  Cores _backgroundcolor = Cores.white;

  @override
  Widget build(BuildContext context) {
    final colorState = Provider.of<ColorState>(context, listen: false);
    return Scaffold(
      backgroundColor: colorState.backgroundColor,
      appBar: AppBar(
        title: Text('Configurações'),
        backgroundColor: colorState.appBarColor,
      ),
      body: Column(
        children: [
          Text(
            'Tema',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Text(
                    'Cor da barra de tarefas',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  DropdownButton<Cores>(
                    value: _appbarcolor,
                    hint: Text('Selecione uma cor'),
                    isExpanded: true,
                    items: Cores.values.map((e) => DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          Text(
                            e.displayString,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                    onChanged: (value) => setState(() {
                      _appbarcolor = value!;
                    }),
                  ),
                  Text(
                    'Cor de fundo',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  DropdownButton<Cores>(
                    value: _backgroundcolor,
                    hint: Text('Selecione uma cor'),
                    isExpanded: true,
                    items: Cores.values.map((e) => DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          Text(
                            e.displayString,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      )).toList(),
                    onChanged: (value) => setState(() {
                      _backgroundcolor = value!;
                    }),
                  ),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                        colorState.changeColor(_backgroundcolor.color, _appbarcolor.color);
                        },
                      child: Text('Atualizar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
