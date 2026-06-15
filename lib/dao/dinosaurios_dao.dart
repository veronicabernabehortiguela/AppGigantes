import 'package:cloud_firestore/cloud_firestore.dart';

import '../modelos/dinosaurio.dart';

class DinosaurioDAO {

  // =====================================
  // COLECCIÓN FIRESTORE
  // =====================================

  final CollectionReference coleccionDinosaurios =

  FirebaseFirestore.instance
      .collection("dinosaurios");

  // =====================================
  // OBTENER DINOSAURIOS
  // =====================================

  Stream<List<Dinosaurio>>
  obtenerDinosaurios() {

    return coleccionDinosaurios
        .snapshots()
        .map(

          (snapshot) {

        return snapshot.docs.map(

              (documento) {

            final datos =
            documento.data()
            as Map<String, dynamic>;

            return Dinosaurio
                .fromFirestore(
              datos,
            );

          },
        ).toList();
      },
    );
  }
}