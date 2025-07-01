import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../models/BmiEntryModel.dart';
import 'categories_screen.dart';
import 'input_screen.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localization_extension.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';

class HistoryScreen extends StatefulWidget {
  final DbService dbService;
  final int userId;

  const HistoryScreen({super.key, required this.dbService, required this.userId});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with RouteAware {
  late Future<List<BmiEntryModel>> _entriesFuture;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() {
    _entriesFuture = widget.dbService.getBmiEntries(widget.userId);
  }

  @override
  void didPopNext() {
    // Called when user comes back to this screen
    _loadEntries();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  Future<bool> _confirmDelete(BuildContext context, int entryId) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteEntryTitle),
        content: Text(l10n.deleteEntryConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              l10n.delete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }

  Future<void> _navigateToAddBmiEntry() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InputScreen(dbService: widget.dbService, userId: widget.userId),
      ),
    );
    if (result == true) {
      _loadEntries();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.historyTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoriesScreen(
                    dbService: widget.dbService,
                    userId: widget.userId,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<BmiEntryModel>>(
        future: _entriesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final entries = snapshot.data!;
          if (entries.isEmpty) {
            return Center(child: Text(l10n.noEntriesFound));
          }

          entries.sort((a, b) => b.entry.date.compareTo(a.entry.date));

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final e = entries[index];

              return Dismissible(
                key: Key(e.entry.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (_) => _confirmDelete(context, e.entry.id),
                onDismissed: (_) async {
                  setState(() {
                    entries.removeAt(index);
                  });
                  await widget.dbService.deleteBmiEntry(e.entry.id, widget.userId);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _loadEntries();
                    setState(() {});
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.entryDeleted)),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      l10n.bmiCategoryValue(
                        e.entry.value.toStringAsFixed(1),
                          AppLocalizations.of(context)!.localizeCategory(e.category.name)
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.entryDetails(
                            e.entry.weight.toStringAsFixed(1),
                            e.entry.height.toStringAsFixed(0),
                            DateFormat("dd.MM.yyyy").add_Hm().format(DateTime.parse(e.entry.date)),
                          ),
                        ),
                        if (e.goalName.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: e.goalName.map((desc) {
                                return Row(
                                  children: [
                                    const Icon(Icons.emoji_events, size: 16, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text(
                                      l10n.goal_bmi_achieved(double.tryParse(desc) != null
                                          ? desc
                                          : AppLocalizations.of(context)!.localizeCategory(desc))
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddBmiEntry,
        child: const Icon(Icons.add),
      ),
    );
  }
}
