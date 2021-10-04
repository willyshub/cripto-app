import 'package:cripto_api_flutter/repository/coin_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
          text: "CriptoApp",
          children: [
            TextSpan(
              text:
                  " (${Provider.of<CoinRepository>(context, listen: true).table.length})",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        )),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        edgeOffset: 5.0,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          await CoinRepository.instance.getSetupDataTable;
        },
        child: FutureBuilder<void>(
            future: CoinRepository.instance.getSetupDataTable,
            builder: (context, futureProvider) {
              final coinRepository = context.read<CoinRepository>();
              if (futureProvider.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      color: Colors.pink[900],
                    ),
                  ),
                );
              }
              if (futureProvider.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: coinRepository.table.length,
                    itemBuilder: (contex, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 30),
                              behavior: SnackBarBehavior.floating,
                              action: SnackBarAction(
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                },
                                label: "Ok",
                                textColor: Colors.pink[50],
                              ),
                              backgroundColor: Colors.pink[900],
                              content: Text(
                                coinRepository.table[index].description,
                              ),
                            ),
                          );
                        },
                        leading: ClipOval(
                          child: Image.network(
                            coinRepository.table[index].icone,
                          ),
                        ),
                        title: Text(
                          coinRepository.table[index].nome,
                        ),
                        subtitle: Text(coinRepository.table[index].preco),
                        //isThreeLine: true,
                        trailing: Text(coinRepository.table[index].sigla),
                      );
                    });
              }
              return Center(
                  child: Text(
                "Error ao carregar os dados",
                textAlign: TextAlign.center,
              ));
            }),
      ),
    );
  }
}
