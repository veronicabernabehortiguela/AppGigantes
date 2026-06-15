import 'package:cloud_firestore/cloud_firestore.dart';

import '../modelos/taller.dart';

class TallerDAO {

  // =====================================
  // REFERENCIA COLECCIÓN
  // =====================================

  final CollectionReference coleccionTalleres =

  FirebaseFirestore.instance
      .collection("talleres");

  // =====================================
  // OBTENER TALLERES
  // =====================================

  Stream<List<Taller>> obtenerTalleres() {

    return coleccionTalleres.snapshots().map(

          (snapshot) {

        return snapshot.docs.map(

              (documento) {

            final datos =
            documento.data()
            as Map<String, dynamic>;

            return Taller.fromFirestore(
              datos,
            );

          },
        ).toList();
      },
    );
  }
}