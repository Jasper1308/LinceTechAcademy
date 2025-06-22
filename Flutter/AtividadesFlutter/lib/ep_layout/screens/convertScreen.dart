import 'package:flutter/material.dart';
import '../models/enums.dart';
import 'package:provider/provider.dart';

class ConvertUnit extends StatefulWidget {
  const ConvertUnit({super.key});

  @override
  State<ConvertUnit> createState() => _ConvertUnitState();
}

class _ConvertUnitState extends State<ConvertUnit> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                BackButton(onPressed: () => Navigator.pop(context),),
                Text('Conversor de Unidades'),
              ],
            )
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tipo'),
                DropdownButton<Type>(
                    items: [
                      DropdownMenuItem(child: Text('DistÃ¢ncia'), value: Type.distancia),
                      DropdownMenuItem(child: Text('Peso'), value: Type.peso),
                      DropdownMenuItem(child: Text('Temperatura'), value: Type.temperatura),
                    ],
                    onChanged: (value) {
                      setState(() {

                      });
                    }
                ),
                Text('Quantia'),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}