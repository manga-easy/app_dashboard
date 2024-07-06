import 'package:dashboard_manga_easy/core/config/app_helpes.dart';
import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:dashboard_manga_easy/core/libraries/sdk/helpes.dart';
import 'package:dashboard_manga_easy/main.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/button_padrao_atom.dart';
import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:dashboard_manga_easy/core/libraries/templates/default_page_template.dart';
import 'package:dashboard_manga_easy/modules/emblemas/domain/models/emblema.dart';
import 'package:dashboard_manga_easy/modules/emblemas/presenter/controllers/cria_edita_emblema_controller.dart';
import 'package:flutter/material.dart';

class CriaEditaEmblemaPage extends StatefulWidget {
  static const route = '/CriaEditaEmblema';
  const CriaEditaEmblemaPage({super.key});
  @override
  State<CriaEditaEmblemaPage> createState() => _CriaEditaEmblemaPageState();
}

class _CriaEditaEmblemaPageState extends State<CriaEditaEmblemaPage> {
  final CriaEditaEmblemaController ct = di();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => ct.init(context));
    ct.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    ct.onMessage(listernerMessage);
    super.initState();
  }

  @override
  void dispose() {
    ct.dispose();
    super.dispose();
  }

  void listernerMessage(String? message) {
    if (message != null && mounted) {
      AppHelps.confirmaDialog(
        title: 'Error ⚠️😥',
        content: message,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPageTemplate(
      done: Scaffold(
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
                  ),
                  child: Column(
                    children: [
                      CampoPadraoAtom(
                        hintText: 'Nome do emblema',
                        initialValue: ct.emblema?.name,
                        onChange: (v) => ct.emblema!.name = v,
                      ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      CampoPadraoAtom(
                        hintText: 'Descrição do emblema',
                        initialValue: ct.emblema?.description,
                        numberLines: 3,
                        onChange: (v) => ct.emblema!.description = v,
                      ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Remove ADS',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        value: ct.emblema?.adsOff ?? false,
                        onChanged: (v) {
                          ct.emblema!.adsOff = v;
                          ct.update();
                        },
                      ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      Row(
                        children: [
                          Text(
                            'Beneficios',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.defaultPadding * 2,
                        ),
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
                                    ct.update();
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                                IconButton(
                                  onPressed: () {
                                    ct.emblema!.benefits.removeLast();
                                    ct.update();
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
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
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: ct.emblema?.categoria,
                        items: CategoriaEmblema.values
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e.name,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          ct.emblema!.categoria = v!;
                          ct.update();
                        },
                      ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Disponivel para resgatar',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        value: ct.emblema?.disponivel ?? false,
                        onChanged: (v) {
                          ct.emblema!.disponivel = v;
                          ct.update();
                        },
                      ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      Row(
                        children: [
                          Text(
                            'Data de criação: ${Helps.formetDateFromTimestap(ct.emblema?.createAt ?? 0)}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      Row(
                        children: [
                          Text(
                            'Tipo de imagem',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: ct.emblema?.type,
                        items: TypeEmblema.values
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e.name,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          ct.emblema!.type = v!;
                          ct.update();
                        },
                      ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      Row(
                        children: [
                          Text(
                            'Raridade',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                      DropdownButton<RarityEmblema>(
                        isExpanded: true,
                        value: ct.emblema?.rarity,
                        items: RarityEmblema.values
                            .map(
                              (e) => DropdownMenuItem<RarityEmblema>(
                                value: e,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          ct.emblema!.rarity = v!;
                          ct.update();
                        },
                      ),
                      const SizedBox(height: AppTheme.defaultPadding),
                      ButtonPadraoAtom(
                        title: 'Adicionar imagem',
                        icone: Icons.image,
                        onPress: () => ct.pickerImage(context),
                      ),
                      const SizedBox(height: AppTheme.defaultPadding * 2),
                      ButtonPadraoAtom(
                        title: 'Salvar',
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
      ),
      state: ct.state,
    );
  }

  List<Widget> beneficios() {
    final widiget = <Widget>[];
    if (ct.emblema == null) {
      return widiget;
    }
    for (var i = 0; i < ct.emblema!.benefits.length; i++) {
      widiget.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: CampoPadraoAtom(
            onChange: (p0) => ct.emblema!.benefits[i] = p0,
            initialValue: ct.emblema!.benefits[i],
          ),
        ),
      );
    }

    return widiget;
  }
}
