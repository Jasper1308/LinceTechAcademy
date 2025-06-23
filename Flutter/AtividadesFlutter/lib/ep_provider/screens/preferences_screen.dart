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
  @override
  Widget build(BuildContext context) {
    final colorState = Provider.of<ColorState>(context);
    return Scaffold(
      backgroundColor: colorState.backgroundColor.color,
      appBar: AppBar(
        title: Text('Configurações'),
        backgroundColor: colorState.appBarColor.color,
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
                    value: colorState.appBarColor,
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
                    onChanged: (value) {
                      if(value != null){
                        colorState.changeAppBarColor(value);
                      }
                    },
                  ),
                  Text(
                    'Cor de fundo',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  DropdownButton<Cores>(
                    value: colorState.backgroundColor,
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
                    onChanged: (value) {
                      if(value != null){
                        colorState.changeBackgroundColor(value);
                      }
                    },
                  ),
                  Text(
                    'Cor de card',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  DropdownButton<Cores>(
                    value: colorState.cardColor,
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
                    onChanged: (value) {
                      if(value != null){
                        colorState.changeCardColor(value);
                      }
                    },
                  ),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/');
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
