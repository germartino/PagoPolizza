import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pago_polizza/main.dart';
import 'package:pago_polizza/navdrawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:pago_polizza/storico.dart';

class AgencyList extends StatelessWidget {
  const AgencyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: const Text("Lista Agenzie"),
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
                  "Scegli l'agenzia",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 30),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width),
                  child: DataTable(
                    showCheckboxColumn: false,
                    dataRowHeight: 70,
                    columnSpacing: 0,
                    columns: const <DataColumn>[
                      DataColumn(
                          label: Text(
                        'Nome Agenzia',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: Colors.black),
                      )),
                      DataColumn(
                          label: Text(
                        'Codice RUI',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: Colors.black),
                      )),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        onSelectChanged: (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Storico()),
                          );
                        },
                        cells: <DataCell>[
                          DataCell(Text('Agenzia1')),
                          DataCell(Text('Codice RUI1')),
                        ],
                      ),
                      DataRow(
                        onSelectChanged: (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Storico()),
                          );
                        },
                        cells: <DataCell>[
                          DataCell(Text('Agenzia2')),
                          DataCell(Text('Codice RUI2')),
                        ],
                      ),
                    ],
                  ),
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
