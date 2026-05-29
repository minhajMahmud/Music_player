
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'admin_store.dart';
import 'ui_helpers.dart';

class SubscriptionsView extends StatefulWidget {
  final AdminStore store;
  final String searchQuery;

  const SubscriptionsView(
      {super.key, required this.store, required this.searchQuery});

  @override
  State<SubscriptionsView> createState() => _SubscriptionsViewState();
}

class _SubscriptionsViewState extends State<SubscriptionsView> {
  @override
  Widget build(BuildContext context) {
    final subs = widget.store.searchSubscriptions(widget.searchQuery);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Subscriptions', style: headingStyle()),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  final created = await showDialog<Subscription>(
                    context: context,
                    builder: (_) => _SubDialog(store: widget.store),
                  );
                  if (created != null) widget.store.addSubscription(created);
                },
                icon: const Icon(LucideIcons.plus, size: 18),
                label: const Text('Add Subscription'),
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
                    DataColumn(label: Text('User Email')),
                    DataColumn(label: Text('Plan')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Renews On')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: subs.map((s) {
                    return DataRow(cells: [
                      DataCell(Text(s.userEmail)),
                      DataCell(Text(s.plan)),
                      DataCell(_StatusChip(status: s.status)),
                      DataCell(Text(formatDate(s.renewsOn))),
                      DataCell(Row(
                        children: [
                          IconButton(
                            tooltip: 'Edit',
                            icon: const Icon(LucideIcons.pencil, size: 18),
                            color: Colors.orange.shade300,
                            onPressed: () async {
                              final updated = await showDialog<Subscription>(
                                context: context,
                                builder: (_) => _SubDialog(store: widget.store, initial: s),
                              );
                              if (updated != null) widget.store.updateSubscription(s.id, updated);
                            },
                          ),
                          IconButton(
                            tooltip: 'Delete',
                            icon: const Icon(LucideIcons.trash2, size: 18),
                            color: Colors.red.shade300,
                            onPressed: () async {
                              final ok = await _confirm(
                                context,
                                'Delete subscription for "${s.userEmail}"?',
                              );
                              if (ok) widget.store.deleteSubscription(s.id);
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

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color fg;
    switch (status) {
      case 'Active':
        fg = Colors.green.shade300;
        break;
      case 'Past Due':
        fg = Colors.orange.shade300;
        break;
      default:
        fg = Colors.red.shade300;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: fg.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Text(status, style: bodyStyle().copyWith(color: fg, fontWeight: FontWeight.w800)),
    );
  }
}

class _SubDialog extends StatefulWidget {
  final AdminStore store;
  final Subscription? initial;
  const _SubDialog({required this.store, this.initial});

  @override
  State<_SubDialog> createState() => _SubDialogState();
}

class _SubDialogState extends State<_SubDialog> {
  String? _userId;
  String? _userEmail;

  String _plan = 'Premium';
  String _status = 'Active';
  DateTime _renewsOn = DateTime.now().add(const Duration(days: 30));

  @override
  void initState() {
    super.initState();
    final s = widget.initial;
    if (s != null) {
      _userId = s.userId;
      _userEmail = s.userEmail;
      _plan = s.plan;
      _status = s.status;
      _renewsOn = s.renewsOn;
    } else {
      if (widget.store.users.isNotEmpty) {
        _userId = widget.store.users.first.id;
        _userEmail = widget.store.users.first.email;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF18181b),
      title: Text(widget.initial == null ? 'Add Subscription' : 'Edit Subscription',
          style: const TextStyle(color: Colors.white)),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade800),
                ),
                child: DropdownButton<String>(
                  value: _userId,
                  isExpanded: true,
                  dropdownColor: const Color(0xFF18181b),
                  underline: const SizedBox.shrink(),
                  iconEnabledColor: Colors.grey.shade400,
                  items: widget.store.users.map((u) {
                    return DropdownMenuItem(
                      value: u.id,
                      child: Text('${u.email} (${u.role})'),
                    );
                  }).toList(),
                  onChanged: (v) {
                    setState(() {
                      _userId = v;
                      _userEmail = widget.store.users
                          .firstWhere((x) => x.id == v)
                          .email;
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _dropdown(
                      value: _plan,
                      label: 'Plan',
                      values: const ['Premium', 'Family', 'Student'],
                      onChanged: (v) => setState(() => _plan = v),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _dropdown(
                      value: _status,
                      label: 'Status',
                      values: const ['Active', 'Canceled', 'Past Due'],
                      onChanged: (v) => setState(() => _status = v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Renews on', style: TextStyle(color: Colors.white)),
                subtitle: Text(formatDate(_renewsOn),
                    style: TextStyle(color: Colors.grey.shade400)),
                trailing: IconButton(
                  icon: const Icon(LucideIcons.calendar, color: Colors.white),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _renewsOn,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                      builder: (context, child) => Theme(
                        data: ThemeData.dark().copyWith(
                          colorScheme: ColorScheme.dark(
                            primary: Colors.orange.shade400,
                          ),
                        ),
                        child: child!,
                      ),
                    );
                    if (picked != null) setState(() => _renewsOn = picked);
                  },
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            if (_userId == null || _userEmail == null) return;
            Navigator.pop(
              context,
              Subscription(
                id: widget.initial?.id ?? '',
                userId: _userId!,
                userEmail: _userEmail!,
                plan: _plan,
                status: _status,
                renewsOn: _renewsOn,
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

  Widget _dropdown({
    required String value,
    required String label,
    required List<String> values,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        dropdownColor: const Color(0xFF18181b),
        underline: const SizedBox.shrink(),
        iconEnabledColor: Colors.grey.shade400,
        items: values.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: (v) => onChanged(v ?? value),
      ),
    );
  }
}
