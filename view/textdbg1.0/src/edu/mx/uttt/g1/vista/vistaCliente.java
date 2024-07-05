/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.mx.uttt.g1.vista;
import edu.mx.uttt.g1.entidad.Cliente;
import edu.mx.uttt.g1.model.Modelocliente;
import edu.mx.uttt.g1.conexion.Conexion;
public class vistaCliente {
    public static void main(String[] args) {
  
        Cliente cli = new Cliente();
        
        cli.setCustomerID("CLIB1");
        cli.setCompanyName("pecsi");
        cli.setContactName("Soyla Vaca");
        cli.setContactTitle("gerente asi");
        cli.setCountry("Mexico");
        cli.setAddress("conocido2");
        cli.setCity("tepeji");
        cli.setRegion("Este");
        cli.setFax("4234235245");
        cli.setPhone("23423435");
        cli.setPostalCode("34236");
        
          new Modelocliente().insertar(cli);      
}
}   