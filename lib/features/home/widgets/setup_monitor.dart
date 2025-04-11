import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetupMonitor extends StatefulWidget {
  const SetupMonitor({super.key});

  @override
  State<SetupMonitor> createState() => _SetupMonitorState();
}

class _SetupMonitorState extends State<SetupMonitor> {
  final TextEditingController _addressController = TextEditingController();
  String _selectedType = 'Wallet'; // Default selection
  final List<String> _types = ['Wallet', 'Token', 'Transaction'];
  bool _isValidAddress = false;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  // Basic Solana address validation (checks for proper length and base58 characters)
  bool _validateSolanaAddress(String address) {
    // Basic validation: Solana addresses are 32-44 characters long and base58 encoded
    final RegExp base58Regex = RegExp(r'^[1-9A-HJ-NP-Za-km-z]+$');
    return address.length >= 32 &&
        address.length <= 44 &&
        base58Regex.hasMatch(address);
  }

  void _onAddressChanged(String value) {
    setState(() {
      _isValidAddress = _validateSolanaAddress(value);
    });
  }

  void _searchAddress() {
    if (!_isValidAddress) return;

    final address = _addressController.text;
    final type = _selectedType;

    // TODO: Navigate to appropriate screen based on type and address
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Searching for $_selectedType: $address')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Setup Solana Monitor',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Address input field
          TextField(
            controller: _addressController,
            decoration: InputDecoration(
              labelText: 'Enter Solana Address',
              hintText: 'e.g., 5U3b...',
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
              suffixIcon:
                  _addressController.text.isNotEmpty
                      ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _addressController.clear();
                          setState(() {
                            _isValidAddress = false;
                          });
                        },
                      )
                      : null,
              errorText:
                  _addressController.text.isNotEmpty && !_isValidAddress
                      ? 'Please enter a valid Solana address'
                      : null,
            ),
            onChanged: _onAddressChanged,
            maxLines: 1,
            style: const TextStyle(fontFamily: 'Monospace'),
            inputFormatters: [
              // Limit length to max Solana address length
              LengthLimitingTextInputFormatter(44),
            ],
          ),

          const SizedBox(height: 24),

          // Type selection
          Text(
            'Select lookup type:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),

          // Selection chips
          Wrap(
            spacing: 8.0,
            children:
                _types.map((type) {
                  return ChoiceChip(
                    label: Text(type),
                    selected: _selectedType == type,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedType = type;
                        });
                      }
                    },
                  );
                }).toList(),
          ),

          const SizedBox(height: 32),

          // Search button
          ElevatedButton(
            onPressed: _isValidAddress ? _searchAddress : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: Text(
              'Search $_selectedType',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
