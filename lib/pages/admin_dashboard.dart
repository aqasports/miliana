import '../services/auth_service.dart';
import '../models/user_model.dart';
import 'login_page.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/chikh_model.dart';
import '../models/mutun_model.dart';
import '../models/order_model.dart';
import '../services/firestore_service.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}


class _AdminDashboardState extends State<AdminDashboard> with SingleTickerProviderStateMixin {
  /// Tab 1: Manage Chikhs
  Widget _buildChikhsTab() {
    return StreamBuilder<List<Chikh>>(
      stream: _firestoreService.getChikhsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'خطأ: {snapshot.error}',
              style: const TextStyle(fontFamily: 'Cairo', color: Colors.red),
            ),
          );
        }
        final chikhs = snapshot.data ?? [];
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionHeader('قائمة الشيوخ'),
                const SizedBox(height: 12),
                _buildAddButton(
                  label: 'إضافة شيخ جديد',
                  onPressed: _showAddChikhDialog,
                ),
                const SizedBox(height: 16),
                if (chikhs.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'لا توجد شيوخ',
                        style: TextStyle(fontFamily: 'Cairo', color: AppColors.gray),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: chikhs.length,
                    itemBuilder: (context, index) {
                      return _buildChikhCard(chikhs[index], index, chikhs);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Tab 2: Manage Mutuns
  Widget _buildMutunsTab() {
    return StreamBuilder<List<Mutun>>(
      stream: _firestoreService.getMutunsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'خطأ: {snapshot.error}',
              style: const TextStyle(fontFamily: 'Cairo', color: Colors.red),
            ),
          );
        }
        final mutuns = snapshot.data ?? [];
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionHeader('قائمة المتون'),
                const SizedBox(height: 12),
                _buildAddButton(
                  label: 'إضافة متن جديد',
                  onPressed: _showAddMutunDialog,
                ),
                const SizedBox(height: 16),
                if (mutuns.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'لا توجد متون',
                        style: TextStyle(fontFamily: 'Cairo', color: AppColors.gray),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mutuns.length,
                    itemBuilder: (context, index) {
                      return _buildMutunCard(mutuns[index], index, mutuns);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Tab 3: Manage Orders
  Widget _buildOrdersTab() {
    return StreamBuilder<List<OrderClass>>(
      stream: _firestoreService.getOrdersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'خطأ: {snapshot.error}',
              style: const TextStyle(fontFamily: 'Cairo', color: Colors.red),
            ),
          );
        }
        final orders = snapshot.data ?? [];
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionHeader('طلبات الالتحاق'),
                const SizedBox(height: 12),
                _buildOrdersStats(orders),
                const SizedBox(height: 16),
                if (orders.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'لا توجد طلبات',
                        style: TextStyle(fontFamily: 'Cairo', color: AppColors.gray),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return _buildOrderCard(orders[index], index);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
        color: AppColors.deepBlue,
      ),
    );
  }

  Widget _buildAddButton({required String label, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      label: Text(
        label,
        style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.deepBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  Widget _buildChikhCard(Chikh chikh, int index, List<Chikh> chikhs) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chikh.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color: AppColors.deepBlue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        chikh.bio,
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'Cairo',
                          color: AppColors.gray,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showEditChikhDialog(chikh, chikhs);
                    } else if (value == 'delete') {
                      _deleteChikh(chikh);
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: AppColors.deepBlue),
                          SizedBox(width: 8),
                          Text('تعديل', style: TextStyle(fontFamily: 'Cairo')),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('حذف', style: TextStyle(fontFamily: 'Cairo')),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: Text(
                    'عدد المتون: ${chikh.mutunIds.length}',
                    style: const TextStyle(fontFamily: 'Cairo'),
                  ),
                  backgroundColor: AppColors.lightBlue.withAlpha((0.2 * 255).round()),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMutunCard(Mutun mutun, int index, List<Mutun> mutuns) {
    return StreamBuilder<Chikh?>(
      stream: _firestoreService.getChikhsStream().map((chikhs) {
        return chikhs.firstWhere((c) => c.id == mutun.chikhId,
            orElse: () => Chikh(
              id: '',
              name: 'غير محدد',
              bio: '',
              imageUrl: '',
              mutunIds: [],
            ));
      }),
      builder: (context, snapshot) {
        final chikh = snapshot.data ??
            Chikh(
              id: '',
              name: 'غير محدد',
              bio: '',
              imageUrl: '',
              mutunIds: [],
            );
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mutun.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              color: AppColors.deepBlue,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'المؤلف: ${mutun.author}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: 'Cairo',
                              color: AppColors.gray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          _showEditMutunDialog(mutun);
                        } else if (value == 'delete') {
                          _deleteMutun(mutun);
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: AppColors.deepBlue),
                              SizedBox(width: 8),
                              Text('تعديل', style: TextStyle(fontFamily: 'Cairo')),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 8),
                              Text('حذف', style: TextStyle(fontFamily: 'Cairo')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                      label: Text(
                        'المستوى: ${mutun.level}',
                        style: const TextStyle(fontFamily: 'Cairo'),
                      ),
                      backgroundColor: _getLevelColor(mutun.level),
                    ),
                    Chip(
                      label: Text(
                        'الشيخ: ${chikh.name}',
                        style: const TextStyle(fontFamily: 'Cairo', fontSize: 12),
                      ),
                      backgroundColor: AppColors.cream,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrderCard(OrderClass order, int index) {
    final statusColor = _getStatusColor(order.status);
    final statusLabel = _getStatusLabel(order.status);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.studentName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color: AppColors.deepBlue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'المتن: ${order.mutunName}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'Cairo',
                          color: AppColors.gray,
                        ),
                      ),
                    ],
                  ),
                ),
                Chip(
                  label: Text(
                    statusLabel,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: statusColor,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الهاتف: ${order.phone}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Cairo',
                    color: AppColors.gray,
                  ),
                ),
                Text(
                  'التاريخ: ${order.date.day}/${order.date.month}/${order.date.year}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Cairo',
                    color: AppColors.gray,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (order.status == 'pending')
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _updateOrderStatus(order.id, 'approved'),
                        icon: const Icon(Icons.check, size: 16),
                        label: const Text(
                          'موافقة',
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () => _updateOrderStatus(order.id, 'rejected'),
                        icon: const Icon(Icons.close, size: 16),
                        label: const Text(
                          'رفض',
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersStats(List<OrderClass> orders) {
    final pending = orders.where((o) => o.status == 'pending').length;
    final approved = orders.where((o) => o.status == 'approved').length;
    final rejected = orders.where((o) => o.status == 'rejected').length;
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('قيد الانتظار', pending.toString(), Colors.orange),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard('موافق عليها', approved.toString(), Colors.green),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard('مرفوضة', rejected.toString(), Colors.red),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String count, Color color) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color.withAlpha((0.1 * 255).round()),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Cairo',
                color: AppColors.gray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddChikhDialog() {
    final nameController = TextEditingController();
    final bioController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة شيخ جديد', style: TextStyle(fontFamily: 'Cairo')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'اسم الشيخ',
                  labelStyle: TextStyle(fontFamily: 'Cairo'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: bioController,
                decoration: const InputDecoration(
                  labelText: 'السيرة',
                  labelStyle: TextStyle(fontFamily: 'Cairo'),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                try {
                  final newChikh = Chikh(
                    id: 'chikh_${DateTime.now().millisecondsSinceEpoch}',
                    name: nameController.text,
                    bio: bioController.text,
                    imageUrl: 'assets/images/logo.png',
                    mutunIds: [],
                  );
                  await _firestoreService.addChikh(newChikh);
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم إضافة الشيخ بنجاح', style: TextStyle(fontFamily: 'Cairo')),
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('خطأ: $e')),
                    );
                  }
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.deepBlue,
            ),
            child: const Text('إضافة', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showEditChikhDialog(Chikh chikh, List<Chikh> chikhs) {
    final nameController = TextEditingController(text: chikh.name);
    final bioController = TextEditingController(text: chikh.bio);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل الشيخ', style: TextStyle(fontFamily: 'Cairo')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'اسم الشيخ',
                  labelStyle: TextStyle(fontFamily: 'Cairo'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: bioController,
                decoration: const InputDecoration(
                  labelText: 'السيرة',
                  labelStyle: TextStyle(fontFamily: 'Cairo'),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                try {
                  final updatedChikh = Chikh(
                    id: chikh.id,
                    name: nameController.text,
                    bio: bioController.text,
                    imageUrl: chikh.imageUrl,
                    mutunIds: chikh.mutunIds,
                  );
                  await _firestoreService.updateChikh(updatedChikh);
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم تحديث الشيخ بنجاح', style: TextStyle(fontFamily: 'Cairo')),
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('خطأ: $e')),
                    );
                  }
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.deepBlue,
            ),
            child: const Text('حفظ', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAddMutunDialog() {
    final nameController = TextEditingController();
    final authorController = TextEditingController();
    final descController = TextEditingController();
    String? selectedChikhId;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('إضافة متن جديد', style: TextStyle(fontFamily: 'Cairo')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'اسم المتن',
                    labelStyle: TextStyle(fontFamily: 'Cairo'),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: authorController,
                  decoration: const InputDecoration(
                    labelText: 'المؤلف',
                    labelStyle: TextStyle(fontFamily: 'Cairo'),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'الوصف',
                    labelStyle: TextStyle(fontFamily: 'Cairo'),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                StreamBuilder<List<Chikh>>(
                  stream: _firestoreService.getChikhsStream(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const SizedBox.shrink();
                    final chikhs = snapshot.data ?? [];
                    return DropdownButtonFormField<String>(
                      value: selectedChikhId,
                      decoration: const InputDecoration(
                        labelText: 'الشيخ',
                        labelStyle: TextStyle(fontFamily: 'Cairo'),
                        border: OutlineInputBorder(),
                      ),
                      items: chikhs.map((chikh) {
                        return DropdownMenuItem(
                          value: chikh.id,
                          child: Text(chikh.name, style: const TextStyle(fontFamily: 'Cairo')),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => selectedChikhId = value),
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty && selectedChikhId != null) {
                  try {
                    final newMutun = Mutun(
                      id: 'mutun_${DateTime.now().millisecondsSinceEpoch}',
                      name: nameController.text,
                      author: authorController.text,
                      littleDesc: descController.text,
                      description: descController.text,
                      level: 'Intermediate',
                      chikhId: selectedChikhId!,
                      videoPlaylistUrls: [],
                      pdfLinks: [],
                      sharhVideoUrls: [],
                      pdfMatenUrl: '',
                      pdfSharhUrl: '',
                      bookTitle: '',
                      bookAuthor: '',
                      bookDescription: '',
                    );
                    await _firestoreService.addMutun(newMutun);
                    if (mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم إضافة المتن بنجاح', style: TextStyle(fontFamily: 'Cairo')),
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('خطأ: $e')),
                      );
                    }
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deepBlue,
              ),
              child: const Text('إضافة', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditMutunDialog(Mutun mutun) {
    final nameController = TextEditingController(text: mutun.name);
    final authorController = TextEditingController(text: mutun.author);
    final descController = TextEditingController(text: mutun.description);
    String? selectedChikhId = mutun.chikhId;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('تعديل المتن', style: TextStyle(fontFamily: 'Cairo')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'اسم المتن',
                    labelStyle: TextStyle(fontFamily: 'Cairo'),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: authorController,
                  decoration: const InputDecoration(
                    labelText: 'المؤلف',
                    labelStyle: TextStyle(fontFamily: 'Cairo'),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'الوصف',
                    labelStyle: TextStyle(fontFamily: 'Cairo'),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                StreamBuilder<List<Chikh>>(
                  stream: _firestoreService.getChikhsStream(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const SizedBox.shrink();
                    final chikhs = snapshot.data ?? [];
                    return DropdownButtonFormField<String>(
                      value: selectedChikhId,
                      decoration: const InputDecoration(
                        labelText: 'الشيخ',
                        labelStyle: TextStyle(fontFamily: 'Cairo'),
                        border: OutlineInputBorder(),
                      ),
                      items: chikhs.map((chikh) {
                        return DropdownMenuItem(
                          value: chikh.id,
                          child: Text(chikh.name, style: const TextStyle(fontFamily: 'Cairo')),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => selectedChikhId = value),
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty && selectedChikhId != null) {
                  try {
                    final updatedMutun = Mutun(
                      id: mutun.id,
                      name: nameController.text,
                      author: authorController.text,
                      littleDesc: descController.text,
                      description: descController.text,
                      level: mutun.level,
                      chikhId: selectedChikhId!,
                      videoPlaylistUrls: mutun.videoPlaylistUrls,
                      pdfLinks: mutun.pdfLinks,
                      sharhVideoUrls: mutun.sharhVideoUrls,
                      pdfMatenUrl: mutun.pdfMatenUrl,
                      pdfSharhUrl: mutun.pdfSharhUrl,
                      bookTitle: mutun.bookTitle,
                      bookAuthor: mutun.bookAuthor,
                      bookDescription: mutun.bookDescription,
                    );
                    await _firestoreService.updateMutun(updatedMutun);
                    if (mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم تحديث المتن بنجاح', style: TextStyle(fontFamily: 'Cairo')),
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('خطأ: $e')),
                      );
                    }
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deepBlue,
              ),
              child: const Text('حفظ', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteChikh(Chikh chikh) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الشيخ', style: TextStyle(fontFamily: 'Cairo')),
        content: Text(
          'هل أنت متأكد من حذف ${chikh.name}؟',
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await _firestoreService.deleteChikh(chikh.id);
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم حذف الشيخ', style: TextStyle(fontFamily: 'Cairo')),
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('خطأ: $e')),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حذف', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _deleteMutun(Mutun mutun) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف المتن', style: TextStyle(fontFamily: 'Cairo')),
        content: Text(
          'هل أنت متأكد من حذف ${mutun.name}؟',
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await _firestoreService.deleteMutun(mutun.id, mutun.chikhId);
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم حذف المتن', style: TextStyle(fontFamily: 'Cairo')),
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('خطأ: $e')),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حذف', style: TextStyle(fontFamily: 'Cairo', color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _updateOrderStatus(String orderId, String newStatus) async {
    try {
      await _firestoreService.updateOrderStatus(orderId, newStatus);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'تم تحديث حالة الطلب إلى ${_getStatusLabel(newStatus)}',
              style: const TextStyle(fontFamily: 'Cairo'),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: $e')),
        );
      }
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      default:
        return AppColors.gray;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'pending':
        return 'قيد الانتظار';
      case 'approved':
        return 'موافق عليها';
      case 'rejected':
        return 'مرفوضة';
      case 'completed':
        return 'مكتملة';
      default:
        return status;
    }
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case 'Beginner':
        return Colors.green.withAlpha((0.2 * 255).round());
      case 'Intermediate':
        return Colors.orange.withAlpha((0.2 * 255).round());
      case 'Advanced':
        return Colors.red.withAlpha((0.2 * 255).round());
      default:
        return AppColors.cream;
    }
  }

  Future<void> _checkAdminRole() async {
    final user = await _auth.getCurrentAppUser();
    if (user == null || user.role != UserRole.admin) {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => LoginPage()),
          (route) => false,
        );
      }
    } else {
      setState(() {
        _currentUser = user;
      });
    }
  }
  // --- Helper fields ---
  AppUser? _currentUser;
  final AuthService _auth = AuthService();
  late TabController _tabController;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAdminRole();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'لوحة التحكم الإدارية',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.deepBlue,
        elevation: 5,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'تسجيل خروج',
            onPressed: () async {
              await _auth.signOut();
              if (mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => LoginPage()),
                  (route) => false,
                );
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.lightBlue,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'الشيوخ'),
            Tab(text: 'المتون'),
            Tab(text: 'الطلبات'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChikhsTab(),
          _buildMutunsTab(),
          _buildOrdersTab(),
        ],
      ),
    );
  }

}


