import 'package:flutter/material.dart';
import 'package:kas_personal/providers/kas_provider.dart';
import 'package:kas_personal/models/kas.dart';
import 'package:provider/provider.dart';

class RekapKasScreen extends StatefulWidget {
  const RekapKasScreen({super.key});

  @override
  State<RekapKasScreen> createState() => _RekapKasScreenState();
}

class _RekapKasScreenState extends State<RekapKasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Transaksi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<KasProvider>(
        builder: (context, kasProvider, child) {
          final items = kasProvider.items;

          // Kalkulasi pemasukan, pengeluaran, dan saldo
          double totalPemasukan = 0;
          double totalPengeluaran = 0;

          for (var kas in items) {
            if (kas.jenis == JenisKas.kasMasuk) {
              totalPemasukan += kas.nominal;
            } else {
              totalPengeluaran += kas.nominal;
            }
          }

          double saldo = totalPemasukan - totalPengeluaran;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Bagian header untuk total pemasukan, pengeluaran, dan saldo
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.grey.shade200,
                child: Row(
                  children: [
                    // Pemasukan
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Pemasukan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'IDR ${totalPemasukan.round()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Pengeluaran
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Pengeluaran',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'IDR ${totalPengeluaran.round()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Sisa
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Sisa',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'IDR ${saldo.round()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Daftar transaksi
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: items.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  itemBuilder: (context, index) {
                    final kas = items[index];

                    return ListTile(
                      leading: Icon(
                        kas.jenis == JenisKas.kasMasuk
                            ? Icons.add_circle
                            : Icons.remove_circle,
                        color: kas.jenis == JenisKas.kasMasuk
                            ? Colors.green
                            : Colors.red,
                      ),
                      title: Text(
                        'IDR ${kas.nominal.round()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kas.jenis == JenisKas.kasMasuk
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      subtitle: Text(kas.keterangan),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}