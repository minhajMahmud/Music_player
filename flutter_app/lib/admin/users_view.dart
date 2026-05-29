
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'admin_store.dart';
import 'ui_helpers.dart';

class UsersView extends StatefulWidget {
  final AdminStore store;
  final String searchQuery;

  const UsersView({super.key, required this.store, required this.searchQuery});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  Widget build(BuildContext context) {
    final users = widget.store.searchUsers(widget.searchQuery);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Users', style: headingStyle()),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  final created = await showDialog<AppUser>(
                    context: context,
                    builder: (_) => _UserDialog(),
                  );
                  if (created != null) widget.store.addUser(created);
                },
                icon: const Icon(LucideIcons.plus, size: 18),
                label: const Text('Add User'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade400,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: sectionCard(
              child: SingleChildScrollView(
                child: DataTable(
                  headingTextStyle: bodyStyle().copyWith(
                      fontWeight: FontWeight.w700, color: Colors.grey.shade200),
                  dataTextStyle: bodyStyle().copyWith(color: Colors.grey.shade200),
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Role')),
                    DataColumn(label: Text('Joined')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: users.map((u) {
                    return DataRow(cells: [
                      DataCell(Text(u.name)),
                      DataCell(Text(u.email)),
                      DataCell(Text(u.role)),
                      DataCell(Text(formatDate(u.joined))),
                      DataCell(_StatusPill(active: u.active)),
                      DataCell(Row(
                        children: [
                          IconButton(
                            tooltip: 'Edit',
                            icon: const Icon(LucideIcons.pencil, size: 18),
                            color: Colors.orange.shade300,
                            onPressed: () async {
                              final updated = await showDialog<AppUser>(
                                context: context,
                                builder: (_) => _UserDialog(initial: u),
                              );
                              if (updated != null) widget.store.updateUser(u.id, updated);
                            },
                          ),
                          IconButton(
                            tooltip: u.active ? 'Disable' : 'Enable',
                            icon: Icon(u.active ? LucideIcons.userX : LucideIcons.userCheck, size: 18),
                            color: u.active ? Colors.red.shade300 : Colors.green.shade300,
                            onPressed: () {
                              widget.store.updateUser(
                                u.id,
                                u.copyWith(active: !u.active),
                              );
                            },
                          ),
                          IconButton(
                            tooltip: 'Delete',
                            icon: const Icon(LucideIcons.trash2, size: 18),
                            color: Colors.red.shade300,
                            onPressed: () async {
                              final ok = await _confirm(
                                context,
                                'Delete "${u.email}"? This will also remove their subscriptions.',
                              );
                              if (ok) widget.store.deleteUser(u.id);
                            },
                          ),
                        ],
                      )),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _confirm(BuildContext context, String msg) async {
    final res = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF18181b),
        title: const Text('Confirm', style: TextStyle(color: Colors.white)),
        content: Text(msg, style: TextStyle(color: Colors.grey.shade300)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade400, foregroundColor: Colors.black),
            child: const Text('Delete'),
          )
        ],
      ),
    );
    return res ?? false;
  }
}

class _StatusPill extends StatelessWidget {
  final bool active;
  const _StatusPill({required this.active});

  @override
  Widget build(BuildContext context) {
    final bg = active ? Colors.green.shade400.withOpacity(0.12) : Colors.red.shade400.withOpacity(0.12);
    final fg = active ? Colors.green.shade300 : Colors.red.shade300;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Text(active ? 'Active' : 'Disabled', style: bodyStyle().copyWith(color: fg, fontWeight: FontWeight.w800)),
    );
  }
}

class _UserDialog extends StatefulWidget {
  final AppUser? initial;
  const _UserDialog({this.initial});

  @override
  State<_UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<_UserDialog> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  String _role = 'User';
  bool _active = true;

  @override
  void initState() {
    super.initState();
    final u = widget.initial;
    _name = TextEditingController(text: u?.name ?? '');
    _email = TextEditingController(text: u?.email ?? '');
    _role = u?.role ?? 'User';
    _active = u?.active ?? true;
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF18181b),
      title: Text(widget.initial == null ? 'Add User' : 'Edit User',
          style: const TextStyle(color: Colors.white)),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _name, decoration: darkInputDecoration('Name'), style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 12),
              TextField(controller: _email, decoration: darkInputDecoration('Email'), style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade800),
                ),
                child: DropdownButton<String>(
                  value: _role,
                  isExpanded: true,
                  dropdownColor: const Color(0xFF18181b),
                  underline: const SizedBox.shrink(),
                  iconEnabledColor: Colors.grey.shade400,
                  items: const [
                    DropdownMenuItem(value: 'User', child: Text('User')),
                    DropdownMenuItem(value: 'Moderator', child: Text('Moderator')),
                    DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                  ],
                  onChanged: (v) => setState(() => _role = v ?? 'User'),
                ),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                value: _active,
                onChanged: (v) => setState(() => _active = v),
                activeColor: Colors.orange.shade400,
                title: const Text('Active account', style: TextStyle(color: Colors.white)),
                subtitle: Text('Disable to block login', style: TextStyle(color: Colors.grey.shade400)),
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            final name = _name.text.trim();
            final email = _email.text.trim();
            if (name.isEmpty || email.isEmpty) return;

            Navigator.pop(
              context,
              AppUser(
                id: widget.initial?.id ?? '',
                name: name,
                email: email,
                role: _role,
                joined: widget.initial?.joined ?? DateTime.now(),
                active: _active,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade400,
            foregroundColor: Colors.black,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
