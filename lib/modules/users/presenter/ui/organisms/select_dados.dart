import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/campo_padrao_atom.dart';
import 'package:flutter/material.dart';

class SelectDados<T> extends StatefulWidget {
  final Future<List<T>> Function(String v) future;
  final String Function(T objet) getTitle;
  final String Function(T objet) getSubTitle;
  final bool Function(T objet, String search) onSearch;

  const SelectDados({
    super.key,
    required this.future,
    required this.getSubTitle,
    required this.getTitle,
    required this.onSearch,
  });

  @override
  State<SelectDados<T>> createState() => _SelectDadosState<T>();
}

class _SelectDadosState<T> extends State<SelectDados<T>> {
  final TextEditingController controller = TextEditingController();

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
              onChange: (v) => setState(() {}),
              hintText: 'Digite o nome do $T',
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: FutureBuilder<List<T>>(
                future: widget.future(controller.text),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final dado = snapshot.data![index];
                        if (!widget.onSearch(dado, controller.text)) {
                          return const SizedBox.shrink();
                        }
                        return ListTile(
                          onTap: () => Navigator.pop(context, dado),
                          title: Text(widget.getTitle(dado)),
                          subtitle: Text(
                            widget.getSubTitle(dado),
                            style: Theme.of(context).textTheme.bodyMedium!,
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
