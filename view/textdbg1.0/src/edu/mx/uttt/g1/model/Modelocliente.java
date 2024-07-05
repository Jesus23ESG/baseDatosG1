/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.mx.uttt.g1.model;
import edu.mx.uttt.g1.entidad.Cliente;
import java.sql.PreparedStatement;
import java.sql.Connection;
import edu.mx.uttt.g1.conexion.Conexion;
import java.sql.SQLException;
/**
 *
 * @author jesus
 */
public class Modelocliente {
    private static Connection con;
    public static boolean insertar(Cliente cli){
        boolean sentinel = false;
        PreparedStatement pst = null;
        con = Conexion.conectar();
        
        String sql = """
                     INSERT INTO [dbo].[Customers]
                                ([CustomerID]
                                ,[CompanyName]
                                ,[ContactName]
                                ,[ContactTitle]
                                ,[Address]
                                ,[City]
                                ,[Region]
                                ,[PostalCode]
                                ,[Country]
                                ,[Phone]
                                ,[Fax])
                          VALUES(?,?,?,?,?,?,?,?,?,?,?)""" ;
                try{
                    pst = con.prepareStatement(sql);
                    pst.setString(1, cli.getCustomerID());
                    pst.setString(2, cli.getCompanyName());
                    pst.setString(3, cli.getContactName());
                    pst.setString(4, cli.getContactTitle());
                    pst.setString(5, cli.getAddress());
                    pst.setString(6, cli.getCity());
                    pst.setString(7, cli.getRegion());
                    pst.setString(8, cli.getPostalCode());
                    pst.setString(9, cli.getCountry());
                    pst.setString(10, cli.getPhone());
                    pst.setString(11,cli.getFax());
                                  
                    
                    int numeroFilas = pst.executeUpdate();
                    
                    if (numeroFilas>0) {
                        System.out.println("Se insertarion" + numeroFilas + "filas");
                        sentinel = true;
                    }
                }catch(SQLException e){
                    System.out.println("Error" + e.getMessage());
                }finally{
                    Conexion.cerrarConexion();
                }
             
        return sentinel;
    }
}
