import 'package:flutter/material.dart';
import 'form.dart';
import 'controller.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SU INDUSTRIES',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: TextTheme(
          bodyText2: TextStyle(fontFamily: 'YourCustomFont'),
        ),
      ),
      home: SplashScreen(), // Display the splash screen initially
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Automatically navigate to MyHomePage after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            key: GlobalKey(),
            title: 'SU INDUSTRIES',
          ),
        ),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/su.png',
                width: 200,
                height:
                    200), // Replace 'assets/logo.png' with the path to your logo
            SizedBox(height: 20),
            Text(
              'SU INDUSTRIES',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController invoiceDateController = TextEditingController();
  TextEditingController qtyBsController = TextEditingController();
  TextEditingController qtyRController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  String? selectedState;
  String? selectedOutlet;
  String? selectedBalanceStock;
  String? restockOption;

  Map<String, List<String>> stateOutlets = {
    'Kedah': ['Outlet 1', 'Outlet 2', 'Outlet 3'],
    'Perlis': ['Outlet A', 'Outlet B', 'Outlet C'],
    'Pulau Pinang': ['Outlet X', 'Outlet Y', 'Outlet Z'],
  };

  List<String> states = ['Kedah', 'Perlis', 'Pulau Pinang'];
  List<String> balanceStockOptions = ['SSEC', 'SGIB'];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      SuForm suForm = SuForm(
        selectedState!,
        selectedOutlet!,
        invoiceDateController.text,
        selectedBalanceStock!,
        qtyBsController.text,
        restockOption!,
        restockOption == 'Yes' ? qtyRController.text : '0',
        remarksController.text,
      );

      FormController formController = FormController();

      formController.submitForm(suForm, (String response) {
        print("Response: $response");
        if (response.trim().toLowerCase() ==
            FormController.status_success.toLowerCase()) {
          _showSnackbar("Submitted");

          // Automatically clear fields after 5 seconds
          Future.delayed(Duration(seconds: 5), () {
            setState(() {
              selectedState = null;
              selectedOutlet = null;
              invoiceDateController.clear();
              selectedBalanceStock = null;
              qtyBsController.clear();
              restockOption = null;
              qtyRController.clear();
              remarksController.clear();
            });
          });
        } else {
          _showSnackbar("Submitted! ");
          // Automatically clear fields after 5 seconds
          Future.delayed(Duration(seconds: 5), () {
            setState(() {
              selectedState = null;
              selectedOutlet = null;
              invoiceDateController.clear();
              selectedBalanceStock = null;
              qtyBsController.clear();
              restockOption = null;
              qtyRController.clear();
              remarksController.clear();
            });
          });
        }
      });
    }
  }

  void _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildDropdownButton(
                  selectedState,
                  states,
                  'Select a State',
                  (String? newValue) {
                    setState(() {
                      selectedState = newValue!;
                      selectedOutlet =
                          null; // Reset selectedOutlet when state changes
                    });
                  },
                ),
                if (selectedState != null)
                  _buildDropdownButton(
                    selectedOutlet,
                    stateOutlets[selectedState!]!,
                    'Select an Outlet',
                    (String? newValue) {
                      setState(() {
                        selectedOutlet = newValue!;
                      });
                    },
                  ),
                _buildTextFormField(
                  invoiceDateController,
                  'Invoice Date',
                  'Enter Valid Invoice Date',
                ),
                _buildDropdownButton(
                  selectedBalanceStock,
                  balanceStockOptions,
                  'Select Balance Stock',
                  (String? newValue) {
                    setState(() {
                      selectedBalanceStock = newValue!;
                    });
                  },
                ),
                _buildTextFormField(
                    qtyBsController, 'Quantity', 'Enter Valid Quantity'),
                _buildDropdownButton(
                  restockOption,
                  ['Yes', 'No'],
                  'Restock?',
                  (String? newValue) {
                    setState(() {
                      restockOption = newValue!;
                    });
                  },
                ),
                if (restockOption == 'Yes')
                  _buildTextFormField(
                      qtyRController, 'Quantity', 'Enter Valid Quantity'),
                _buildTextFormField(remarksController, 'Remarks', ''),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                    _showSnackbar("Submitting ");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                  ),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: 200.0,
                    height: 50.0,
                    child: Center(
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String label, String errorText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return errorText;
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdownButton(
    String? value,
    List<String> items,
    String hint,
    void Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
