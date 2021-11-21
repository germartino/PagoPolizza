import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pago_polizza/main.dart';
import 'package:pago_polizza/navdrawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class Storico extends StatelessWidget {
  const Storico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Storico pagamenti"),
        backgroundColor: Colors.tealAccent[700],
      ),
      body: DoubleBackToCloseApp(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                Text(
                  MyApp.title,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.tealAccent[700],
                  ),
                ),
                Text(
                  "Storico dei pagamenti",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 30),
                DataTable(
                  dataRowHeight: 90,
                  columnSpacing: 30,
                  columns: const <DataColumn>[
                    DataColumn(
                        label: Text(
                      'Data',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          color: Colors.black),
                    )),
                    DataColumn(
                        label: Text(
                      'Esito',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          color: Colors.black),
                    )),
                    DataColumn(
                        label: Text(
                      'Importo',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          color: Colors.black),
                    )),
                  ],
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('21/11/2021')),
                        DataCell(Text('Effettuato con successo')),
                        DataCell(Text('150.50')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('20/11/2021')),
                        DataCell(Text('Non effettuato')),
                        DataCell(Text('150.50')),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        snackBar: const SnackBar(
          content: Text('Premi di nuovo per uscire'),
          backgroundColor: Color(0xff00bfa5),
        ),
      ),
    );
  }
}
