
import 'package:flutter/material.dart';
//import 'app_screens/home.dart';
import 

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Intrest Calculator App',
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      ),
    )
  );
}    

class SIForm extends StatefulWidget{
  @override 
  State<StatefulWidget> createState(){
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm>{

  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Rupees','Dollars','Pounds','Others'];
  final _minimumPadding = 5.0;

  var _currentItemSelected = '';

  @override 
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  } 
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  
  var displayResult = '';

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,

      appBar: AppBar(
        title: Text("Simple Intrest Calculator"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding*2),
        // margin: EdgeInsets.all(_minimumPadding*2),
        child: ListView(children: <Widget>[
          
          getImageAsset(),
          
          Padding(
            padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
            child:TextFormField(
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.headline6,
              controller: principalController,
              validator: (String value){
                if(value.isEmpty){
                  return 'Please enter principal amount';
                }
                return  "";
              },

              decoration: InputDecoration(  
                labelText: 'Principal',
                hintText: 'Enter Principal e.g 1200',
                labelStyle: Theme.of(context).textTheme.headline6,
                errorStyle: TextStyle(
                  color:  Colors.yellowAccent, 
                  fontSize: 15.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
            ))),
        
            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom:_minimumPadding),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: Theme.of(context).textTheme.headline6,
                controller: roiController,
                validator: (String value){
                if(value.isEmpty){
                  return 'Please enter principal amount';
                }
                  return "";
                },

                decoration: InputDecoration(  
                  labelText: 'Rate Of Intrest',
                  hintText: 'In Percent',
                  errorStyle: TextStyle(
                  color:  Colors.yellowAccent, 
                  fontSize: 15.0,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
            ))),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom:_minimumPadding),
              child: Row(children: <Widget>[

                Expanded(
                child:TextFormField(
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.headline6,
                  controller: termController,
                  validator: (String value){
                if(value.isEmpty){
                  return 'Please enter principal amount';
                }
                  return "";
                },

                  decoration: InputDecoration(  
                    labelText: 'Term',
                    hintText: 'Time in Years',
                    errorStyle: TextStyle(
                      color:  Colors.yellowAccent, 
                      fontSize: 15.0,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                ))),
                
                Container(width: _minimumPadding*5,),

                Expanded(
                  child: DropdownButton<String>(
                    items: _currencies.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  value: _currentItemSelected,
                  onChanged: (String newValueSelected){
                    _onDropDownItemSelected(newValueSelected);  
                  },
                  ))
                ])),

              Padding(
                padding: EdgeInsets.only(top:_minimumPadding, bottom:_minimumPadding),
                child: Row(children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text("Calculate", style: Theme.of(context).textTheme.headline6,),
                    onPressed: () {
                      setState(() {
                        if(_formKey.currentState.validate()){
                          this.displayResult = _calculateTotalReturns();
                        }
                      });
                    },
                  )
                ),
                
                Expanded(
                  child: RaisedButton(
                    child: Text(
                      "Reset", 
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    onPressed: () {
                      setState(() {
                        _reset();
                      });
                    },
                  )
                ),

              ])),

              Padding(
                padding: EdgeInsets.all(_minimumPadding*2),
                child: Text(
                  this.displayResult,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),

        ])
      ),)
    );
  }

Widget getImageAsset(){
  AssetImage assetImage = AssetImage('images/money.png');
  Image image = Image(image:  assetImage,width: 125.0,height: 125.0,);
  return Container(child: image, margin: EdgeInsets.all(_minimumPadding*10),);
}

void _onDropDownItemSelected(String newValueSelected){
  setState(() {
    this._currentItemSelected = newValueSelected;
  });
}

  String _calculateTotalReturns(){

    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal+(principal*roi*term)/100; 

    String result = 'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }

  void _reset(){
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
  
}


