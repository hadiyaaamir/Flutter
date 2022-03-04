import 'package:assignment2/lastScreen.dart';
import 'package:flutter/material.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  final String name;
  final String email;

  @override
  _SaveScreenState createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller1.text = widget.name;
    _controller2.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    // _controller1.text = widget.name;
    // _controller2.text = widget.email;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Credentials'),
      //   centerTitle: true,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField_w_Controller(
              cont: _controller1,
              label: 'Name',
            ),
            const SizedBox(height: 20),
            TextField_w_Controller(
              cont: _controller2,
              label: 'Email',
            ),
            const SizedBox(height: 50),
            SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LastScreen(
                          name: _controller1.text,
                          email: _controller2.text,
                        ),
                      ),
                    );
                    // setState(() {});
                  },
                  child: const Text('Save'),
                )),
          ],
        ),
      ),
    );
  }
}

class TextField_w_Controller extends StatelessWidget {
  const TextField_w_Controller({
    Key? key,
    required this.cont,
    required this.label,
  }) : super(key: key);

  final String label;
  final TextEditingController cont;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
          controller: cont,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1)),
            labelText: label,
          )),
    );
  }
}
