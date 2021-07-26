import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class desplegable extends StatefulWidget {
  final Color color_de_fondo;
  final bool desplegado;
  final Widget title;
  final Widget body;
  //final Widget collapsed;
  desplegable({
    this.title,
    this.body,
    this.color_de_fondo, this.desplegado,
    /*this.collapsed*/
  });

  @override
  _desplegableState createState() => _desplegableState();
}

class _desplegableState extends State<desplegable> {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      initialExpanded: widget.desplegado,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color_de_fondo,
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
