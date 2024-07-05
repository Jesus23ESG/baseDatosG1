package edu.mx.uttt.g1.control;

import java.util.List;

public interface IOperaciones {
   int agregar(Object obj);
   boolean actualizar(Object obj);
   List<Object> consultar();
   boolean eliminar (Object obj);
}
