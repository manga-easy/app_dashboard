import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/atoms/loading_atom.dart';
import 'package:dashboard_manga_easy/modules/emblemas/ui/controllers/cria_edita_emblema_controller.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class CriaEditaEmblemaPage extends StatefulWidget {
  static const route = '/CriaEditaEmblema';
  const CriaEditaEmblemaPage({Key? key}) : super(key: key);
  @override
  State<CriaEditaEmblemaPage> createState() => _CriaEditaEmblemaPageState();
}

class _CriaEditaEmblemaPageState extends State<CriaEditaEmblemaPage> {
  final ct = di.get<CriaEditaEmblemaController>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => ct.onInit(context));
    super.initState();
  }

  @override
  void dispose() {
    ct.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ct,
      builder: (context, value, child) {
        if (ct.emblema == null) return const LoadingAtom();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Criar Emblema'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.defaultPadding),
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppTheme.defaultPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppTheme.secondaryColor,
                    ),
                    child: Column(
                      children: [
                        CampoPadraoAtom(
                          hintText: 'Nome do emblema',
                          initialValue: ct.emblema!.name,
                          onChange: (v) => ct.emblema!.name = v,
                        ),
                        const SizedBox(height: AppTheme.defaultPadding),
                        CampoPadraoAtom(
                          hintText: 'Descrição do emblema',
                          initialValue: ct.emblema!.description,
                          numberLines: 3,
                          onChange: (v) => ct.emblema!.description = v,
                        ),
                        const SizedBox(height: AppTheme.defaultPadding),
                        SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'Remove ADS',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            value: ct.emblema!.adsOff,
                            activeColor: AppTheme.primaryColor,
                            onChanged: (v) {
                              ct.emblema!.adsOff = v;
                              ct.notifyListeners();
                            }),
                        const SizedBox(height: AppTheme.defaultPadding),
                        Row(
                          children: [
                            Text(
                              'Beneficios',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppTheme.defaultPadding * 2),
                          child: Column(
                            children: [
                              const SizedBox(height: AppTheme.defaultPadding / 2),
                              Column(
                                children: beneficios(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      ct.emblema!.benefits.add('');
                                      ct.notifyListeners();
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      ct.emblema!.benefits.removeLast();
                                      ct.notifyListeners();
                                    },
                                    icon: const Icon(Icons.remove),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppTheme.defaultPadding),
                        Row(
                          children: [
                            Text(
                              'Categoria',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          value: ct.emblema!.categoria,
                          items: CategoriaEmblema.values
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e.name),
                                    value: e.name,
                                  ))
                              .toList(),
                          onChanged: (v) {
                            ct.emblema!.categoria = v!;
                            ct.notifyListeners();
                          },
                        ),
                        const SizedBox(height: AppTheme.defaultPadding),
                        SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'Disponivel para resgatar',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            value: ct.emblema!.disponivel,
                            activeColor: AppTheme.primaryColor,
                            onChanged: (v) {
                              ct.emblema!.disponivel = v;
                              ct.notifyListeners();
                            }),
                        const SizedBox(height: AppTheme.defaultPadding),
                        Row(
                          children: [
                            Text(
                              'Tipo de imagem',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          value: ct.emblema!.type,
                          items: TypeEmblema.values
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e.name),
                                    value: e.name,
                                  ))
                              .toList(),
                          onChanged: (v) {
                            ct.emblema!.type = v!;
                            ct.notifyListeners();
                          },
                        ),
                        const SizedBox(height: AppTheme.defaultPadding),
                        Row(
                          children: [
                            Text(
                              'Raridade',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          value: Helps.convertUniqueid(ct.emblema!.rarity.toLowerCase()),
                          items: RarityEmblema.values
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e.name),
                                    value: e.name,
                                  ))
                              .toList(),
                          onChanged: (v) {
                            ct.emblema!.rarity = v!;
                            ct.notifyListeners();
                          },
                        ),
                        const SizedBox(height: AppTheme.defaultPadding),
                        CampoPadraoAtom(
                          hintText: 'Url',
                          initialValue: ct.emblema!.url,
                          onChange: (v) => ct.emblema!.url = v,
                          numberLines: 5,
                        ),
                        const SizedBox(height: AppTheme.defaultPadding * 2),
                        ButtonPadraoAtom(
                          title: 'Criar Emblema',
                          icone: Icons.create,
                          onPress: () => ct.criaAlteraEmblema(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> beneficios() {
    var widiget = <Widget>[];
    for (var i = 0; i < ct.emblema!.benefits.length; i++) {
      widiget.add(Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: CampoPadraoAtom(
          onChange: (p0) => ct.emblema!.benefits[i] = p0,
          initialValue: ct.emblema!.benefits[i],
        ),
      ));
    }

    return widiget;
  }
}
