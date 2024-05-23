import 'package:etracker/expen.dart';
import 'package:flutter/material.dart';

class AddExpences extends StatefulWidget {
  const AddExpences(this.newregister, {super.key});
  final void Function(String newtitle, double newamount, DateTime newdate,
      Category newcategory) newregister;

  @override
  State<AddExpences> createState() {
    return _AddExpencesState();
  }
}

class _AddExpencesState extends State<AddExpences> {
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  DateTime? selectedate;
  Category selectedcategory = Category.travel;

  @override
  void dispose() {
    titlecontroller.dispose();
    amountcontroller.dispose();
    super.dispose();
  }

  void presentdatepicker() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 1, now.month, now.day);
    final pickdate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: first,
      lastDate: now,
    );

    setState(() {
      selectedate = pickdate;
    });
  }

  void submitexpencedata(){
    final enteramount=double.tryParse(amountcontroller.text);
    final amountinvalid= enteramount==null||enteramount<=0;
    if(titlecontroller.text.trim().isEmpty||amountinvalid||selectedate==null){
      showDialog(context: context, builder: (ctx){return AlertDialog(title: Text("Invalid input"),content: Text("Please make sure a valid title, amount, date and category was entered."),actions: [TextButton(onPressed: (){
        Navigator.pop(ctx);
      }, child: Text("Okay"))],);});
      return;
    }
    else{
      widget.newregister(
                    titlecontroller.text,
                    double.parse(amountcontroller.text),
                    selectedate!,
                    selectedcategory,
                  );
                  Navigator.pop(context);
    }
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 16),
      child: Column(
        children: [
          TextField(
            controller: titlecontroller,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: "\u{20B9} ",
                    label: Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(selectedate == null
                        ? "No date selected"
                        : formatter.format(selectedate!)),
                    IconButton(
                      onPressed: presentdatepicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                value: selectedcategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (values) {
                  if (values == null) {
                    return;
                  }
                  setState(() {
                    selectedcategory = values;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: submitexpencedata,
                child: Text("Save Expense"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
