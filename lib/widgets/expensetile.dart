import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile(
      {super.key,
      required this.t,
      required this.color,
      required this.expensename,
      required this.onpressed,
      required this.expenseprice});

  final String t;
  final Color color;
  final String expensename;
  final Function(BuildContext)? onpressed;
  final String expenseprice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: onpressed,
            icon: Icons.delete,
    autoClose: true,
            borderRadius: BorderRadius.circular(15),
            backgroundColor: Colors.black,
          )
        ]),
        child: Container(
          height: 80,
          width: 350,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: color,
                  ),
                  child: Center(
                      child: Text(
                    t.toUpperCase(),
                    style: GoogleFonts.readexPro(
                        color: Colors.grey.shade800, fontSize: 20),
                  )),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                    width: 130,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        expensename.toUpperCase(),
                        style: GoogleFonts.readexPro(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    )),
                const SizedBox(
                  width: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      " \$$expenseprice",
                      style: GoogleFonts.readexPro(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
