import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:flutter/material.dart';
import 'package:page_manager/export_manager.dart';

class SelectDados<T> extends StatefulWidget {
  final Future<List<T>> Function(String v) future;
  final String Function(T objet) getTitle;
  final String Function(T objet) getSubTitle;

  const SelectDados({
    super.key,
    required this.future,
    required this.getSubTitle,
    required this.getTitle,
  });

  @override
  State<SelectDados<T>> createState() => _SelectDadosState<T>();
}

class _SelectDadosState<T> extends State<SelectDados<T>> {
  final TextEditingController controller = TextEditingController();
  final state = ValueNotifier(StateManager.initial);
  var list = [];
  @override
  void initState() {
    loadingApi();
    super.initState();
  }

  Future<void> loadingApi() async {
    state.value = StateManager.loading;
    list = await widget.future(controller.text);
    state.value = StateManager.done;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ListView(
          children: [
            Text(
              'Selecionar $T',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            CampoPadraoAtom(
              controller: controller,
              onChange: (v) => loadingApi(),
              hintText: 'Digite o nome do $T',
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: ValueListenableBuilder(
                builder: (context, value, child) {
                  return switch (state.value) {
                    StateManager.done => ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final dado = list[index];
                          return ListTile(
                            onTap: () => Navigator.pop(context, dado),
                            title: Text(widget.getTitle(dado)),
                            subtitle: Text(
                              widget.getSubTitle(dado),
                              style: Theme.of(context).textTheme.bodyMedium!,
                            ),
                          );
                        },
                      ),
                    _ => const Center(
                        child: CircularProgressIndicator(),
                      )
                  };
                },
                valueListenable: state,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
