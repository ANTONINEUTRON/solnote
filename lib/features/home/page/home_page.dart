import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solnote/features/home/widgets/setup_monitor.dart';
import 'package:solnote/gen/assets.gen.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample data for monitors
  final List<Map<String, dynamic>> _walletMonitors = [
    {
      'address': '5U3bHVZjY7Rc8Uzi6EGnKBCk9BFNx7S3K9Zad4GKxXrq',
      'name': 'My Trading Wallet',
      'balance': '32.45 SOL',
    },
    {
      'address': '7BVRUwj3N7TKXwGPF49KJBe9AcTh2YhLofZGJLhsaX6V',
      'name': 'Cold Storage',
      'balance': '150.78 SOL',
    },
  ];

  final List<Map<String, dynamic>> _tokenMonitors = [
    {
      'symbol': 'BONK',
      'name': 'Bonk',
      'price': '\$0.00000221',
      'change': '+5.2%',
    },
    {'symbol': 'JTO', 'name': 'Jito', 'price': '\$2.45', 'change': '-1.8%'},
    {
      'symbol': 'PYTH',
      'name': 'Pyth Network',
      'price': '\$0.32',
      'change': '+2.3%',
    },
  ];

  final List<Map<String, dynamic>> _transactionMonitors = [
    {
      'hash': '4zH9mG...pQr7',
      'type': 'Swap',
      'status': 'Success',
      'time': '10 min ago',
    },
    {
      'hash': '2xRtY5...8Lmn',
      'type': 'Transfer',
      'status': 'Pending',
      'time': '25 min ago',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        elevation: 1,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Assets.logo.appIconNobg.image(width: 48, height: 48),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              // icon: Icon(Icons.account_balance_wallet),
              text: 'Wallets',
            ),
            Tab(
              // icon: Icon(Icons.token),
              text: 'Tokens',
            ),
            Tab(
              // icon: Icon(Icons.sync_alt),
              text: 'Transactions',
            ),
          ],
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Wallets Tab
          _buildWalletsTab(),

          // Tokens Tab
          _buildTokensTab(),

          // Transactions Tab
          _buildTransactionsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show dialog to add new monitor based on current tab
          _showAddMonitorDialog(_tabController.index);
        },
        child: const Icon(Icons.search),
        tooltip: 'Create monitor',
      ),
    );
  }

  Widget _buildWalletsTab() {
    return _walletMonitors.isEmpty
        ? _buildEmptyState(
          'No wallet monitors yet',
          'Add your first wallet to monitor',
        )
        : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _walletMonitors.length,
          itemBuilder: (context, index) {
            final wallet = _walletMonitors[index];
            return _buildWalletCard(wallet);
          },
        );
  }

  Widget _buildTokensTab() {
    return _tokenMonitors.isEmpty
        ? _buildEmptyState(
          'No token monitors yet',
          'Add your first token to monitor',
        )
        : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _tokenMonitors.length,
          itemBuilder: (context, index) {
            final token = _tokenMonitors[index];
            return _buildTokenCard(token);
          },
        );
  }

  Widget _buildTransactionsTab() {
    return _transactionMonitors.isEmpty
        ? _buildEmptyState(
          'No transaction monitors yet',
          'Add your first transaction to monitor',
        )
        : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _transactionMonitors.length,
          itemBuilder: (context, index) {
            final transaction = _transactionMonitors[index];
            return _buildTransactionCard(transaction);
          },
        );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                int currentTab = _tabController.index;
                _showAddMonitorDialog(currentTab);
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Monitor'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletCard(Map<String, dynamic> wallet) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        wallet['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        wallet['balance'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // Show options menu
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                wallet['address'],
                style: TextStyle(
                  fontFamily: 'Monospace',
                  fontSize: 13,
                  color: Colors.grey[800],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // Copy address
                    Clipboard.setData(ClipboardData(text: wallet['address']));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Address copied to clipboard'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy, size: 16),
                  label: const Text('Copy'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    // View wallet details
                  },
                  icon: const Icon(Icons.visibility, size: 16),
                  label: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenCard(Map<String, dynamic> token) {
    final bool isPositiveChange = token['change'].toString().startsWith('+');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              radius: 24,
              child: Text(
                token['symbol'][0],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        token['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          token['symbol'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        token['price'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isPositiveChange
                                  ? Colors.green[50]
                                  : Colors.red[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          token['change'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color:
                                isPositiveChange
                                    ? Colors.green[700]
                                    : Colors.red[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
              onPressed: () {
                // View token details
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> tx) {
    Color statusColor;
    IconData statusIcon;

    switch (tx['status']) {
      case 'Success':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'Pending':
        statusColor = Colors.orange;
        statusIcon = Icons.pending;
        break;
      default:
        statusColor = Colors.red;
        statusIcon = Icons.error;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Icon(
                    Icons.sync_alt,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx['type'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tx['hash'],
                        style: TextStyle(
                          fontFamily: 'Monospace',
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 14, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        tx['status'],
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tx['time'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                TextButton(
                  onPressed: () {
                    // View transaction details
                  },
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddMonitorDialog(int tabIndex) {
    String title;
    IconData icon;
    String type;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(child: SetupMonitor());
      },
    );
  }
}
