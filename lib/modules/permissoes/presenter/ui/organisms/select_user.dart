import 'package:dashboard_manga_easy/modules/dashboard/atoms/campo_padrao_atom.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class SelectUser extends StatefulWidget {
  final Future<List<User>> Function(String v) future;

  const SelectUser({super.key, required this.future});

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
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
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ListView(
          children: [
            Text(
              'Selecionar usuário',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            CampoPadraoAtom(
              controller: controller,
              onChange: (v) => setState(() {}),
              hintText: "Digite o nome do usuario",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: FutureBuilder<List<User>>(
                future: widget.future(controller.text),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var user = snapshot.data![index];
                        return ListTile(
                          onTap: () => Navigator.pop(context, user),
                          title: Text(user.name),
                          subtitle: Text(
                            user.email,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                ),
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
