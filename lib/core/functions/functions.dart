import 'package:flutter/material.dart';

pushWithReplacement(context, Widget newView){
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context)=> newView)
  );
}

push(context, Widget newView){
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context)=> newView)
  );
}

pop(context, Widget newView){
  Navigator.of(context).pop(
    MaterialPageRoute(builder: (context)=> newView)
  );
}