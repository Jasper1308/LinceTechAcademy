import 'package:flutter/material.dart';

class MoneyConvert extends StatefulWidget {
  const MoneyConvert({super.key});

  @override
  State<MoneyConvert> createState() => _MoneyConvertState();
}

class _MoneyConvertState extends State<MoneyConvert> {
  String conversao = '';
  String resultado = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                BackButton(onPressed: () => Navigator.pop(context),),
                Text('Conversor de Moedas'),
              ],
            )
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Quantia'),
              Row(

                children: [
                  Expanded(child: TextFormField()),
                  DropdownButton(
                      items: [
                        DropdownMenuItem(child: Text('BRL'), value: 'BRL'),
                        DropdownMenuItem(child: Text('USD'), value: 'USD'),
                      ],
                      onChanged: (value) => conversao = value!
                  ),
                ],
              ),
              Text('Converter para'),
              Row(
                children: [
                  Expanded(child: TextFormField()),
                  DropdownButton(
                      items: [
                        DropdownMenuItem(child: Text('BRL'), value: 'BRL'),
                        DropdownMenuItem(child: Text('USD'), value: 'USD')
                      ],
                      onChanged: (value) => resultado = value!
                  ),
                ],
              ),
              Text('data')
            ],
          ),
        ),
      ),
    );
  }
}