import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class desplegable extends StatefulWidget {
  final Color color_de_fondo;
  final Widget title;
  final Widget body;
  //final Widget collapsed;
  desplegable({
    this.title,
    this.body,
    this.color_de_fondo,
    /*this.collapsed*/
  });

  @override
  _desplegableState createState() => _desplegableState();
}

class _desplegableState extends State<desplegable> {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      initialExpanded: false,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color_de_fondo,
          //border: Border.all(color: Colors.blue,),
          //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 20,
              offset: Offset(0, 14), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                  builder: (_, collapsed, expanded) {
                    return Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: ExpandableThemeData(crossFadePoint: 0),
                    );
                  },
                  theme: ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: false,
                    iconColor: Colors.grey,
                    iconSize: 20,
                    iconPadding: EdgeInsets.all(0),
                  ),
                  header: widget.title,
                  expanded: widget.body),
            ),
          ],
        ),
      ),
    );
  }
}
