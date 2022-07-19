import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';

import '../../../core/auth/auth_provider.dart';
import '../../../core/ui/messages.dart';
import '../../../core/ui/theme_extensions.dart';
import '../../../services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key? key}) : super(key: key);

  final nameVN = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<AuthProvider, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ?? '';
                  },
                  builder: (_, photoURL, __) {
                    final hasPhoto = photoURL.isNotEmpty;
                    const radius = 30.0;
                    return Visibility(
                      visible: hasPhoto,
                      replacement: CircleAvatar(
                        radius: radius,
                        backgroundColor: context.primaryColor,
                        child: Icon(
                          Icons.person,
                          size: 32,
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(photoURL),
                        radius: radius,
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthProvider, String>(
                      selector: (context, authProvider) {
                        return authProvider.user?.displayName ??
                            'Não informado';
                      },
                      builder: (_, value, __) {
                        return Text(
                          value,
                          style: context.textTheme.subtitle2,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Alterar Nome'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Alterar Nome'),
                    content: TextField(
                      onChanged: (value) => nameVN.value = value,
                    ),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          _updateDisplayName(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Alterar'),
                      )
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            title: const Text('Sair'),
            onTap: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
    );
  }

  Future<void> _updateDisplayName(BuildContext context) async {
    final name = nameVN.value;
    if (name.isEmpty) {
      Messages.of(context).showError('Campo obrigatório');
      return;
    }
    Loader.show(context);
    await context.read<UserService>().updateDisplayName(name);
    Loader.hide();
  }
}
