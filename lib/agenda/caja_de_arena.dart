import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class sub_arbol_menu extends StatefulWidget {
  sub_arbol_menu({Key key}) : super(key: key);

  @override
  _sub_arbol_menuState createState() => _sub_arbol_menuState();
}

class _sub_arbol_menuState extends State<sub_arbol_menu> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TreeView<SimpleNode>(
        initialItem: SimpleNode(" "),
        expansionBehavior: ExpansionBehavior.collapseOthersAndSnapToTop,
        shrinkWrap: false,
        builder: (context, level, item) => item.isRoot
            ? raizItem(level, item)
            : listItem(level, item),
      ),
    );
  }




  Widget raizItem(int level, SimpleNode item) {
    return Card(
      child: Row(
        children: [
          Text("   Item ${item.level}-${item.key}  "),
          ElevatedButton(
            onPressed: () => item.add(SimpleNode()), child: Text("Add")),
        ],
      ),
    );
  }

  Widget listItem(int level, SimpleNode item) {
    return Card(
      color: Colors.white,
      child: Container(
        child: Row(
          children: [
            Text("Item ${item.level}-${item.key}"),
            deleteItem(item),
            addItem(item),
            infoItem(item),
          ],
        ),
      ),
    );
  }

  Widget addItem(SimpleNode item) {
    return IconButton(
      onPressed: () => item.add(SimpleNode()),
      icon: Icon(Icons.add_circle, color: Colors.green),
    );
  }

  Widget infoItem(SimpleNode item) {
    return IconButton(
      onPressed: () {
        print("item.length ${item.length}");
        print("item.lehashCodength ${item.hashCode}");
        print("item.path ${item.path}");
        print("item.value ${item.value}");
        print("item.children ${item.children}");
        print("item.childchildrenAsListren ${item.childrenAsList}");
        print("item.parent ${item.parent}");
        print("item.meta ${item.meta}");
        print("item.level ${item.level}");
        //print("item.level ${item.elementAt(path)}");
        //item.add(SimpleNode()),
      },
      icon: Icon(Icons.info_rounded, color: Colors.yellow),
    );
  }


  Widget deleteItem(SimpleNode item) {
    return IconButton(
      onPressed: () => item.delete(),
      icon: Icon(Icons.delete, color: Colors.red),
    );
  }
}

extension ColorUtil on Color {
  Color byLuminance() =>
      this.computeLuminance() > 0.4 ? Colors.black87 : Colors.white;
}
