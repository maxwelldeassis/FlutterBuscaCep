import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viacep/models/address.model.dart';
import 'package:viacep/services/viacep.service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Maxwell BuscaCEP'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => ViaCepProvider(),
        child: HomeScreenBody(),
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViaCepProvider viacepProvider = context.read();
    TextEditingController textController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: textController,
            keyboardType: TextInputType.number,
            autofocus: true,
            onEditingComplete: () => viacepProvider
                .getAddressByCEP(textController.text.replaceAll("^[0-9]", "")),
          ),
          OutlinedButton(
              onPressed: () => viacepProvider.getAddressByCEP(
                  textController.text.replaceAll("^[0-9]", "")),
              child: Text('Buscar')),
          SizedBox(
            height: 20,
          ),
          _resultArea()
        ],
      ),
    );
  }

  Widget _resultArea() {
    return Container(
      child: Center(
        child: Consumer<ViaCepProvider>(
          builder: (context, viacepSearch, child) {
            var mainAddress = Address();
            if (viacepSearch.addresses == null) {
              return Container();
            } else if (viacepSearch.searching) {
              return CircularProgressIndicator();
            } else if (viacepSearch.isErro) {
              return Container(
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.warning_amber_outlined),
                      Text('Resultado não encontrado'),
                    ],
                  ),
                ),
              );
            } else {
              mainAddress = viacepSearch.addresses.first;
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).accentColor),
                ),
                child: ListTile(
                  minVerticalPadding: 15,
                  dense: true,
                  isThreeLine: true,
                  leading: CircleAvatar(child: Text(mainAddress.uf)),
                  title: Text(mainAddress.cep),
                  subtitle: Text('Logradouro: ${mainAddress.logradouro}\n' +
                      'Localidade: ${mainAddress.localidade}\n' +
                      'Bairro: ${mainAddress.bairro}'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
