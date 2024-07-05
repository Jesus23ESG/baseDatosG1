/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.mx.uttt.g1.conexion;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;
/**
 *
 * @author jesus
 */
public class Conexion {
    
    private static Connection con;
    public static Connection conectar(){
        con = null;
        
        String url = 
                "jdbc:sqlserver://localhost:1433;databaseName=NORTHWND;encrypt=true;trustServerCertificate=true";
   
String user = "sa";
String password = "123456";

try{
    con= DriverManager.getConnection(url,user,password);
    System.out.println("Conexion exitosa con la base de datos");
}catch(SQLException e){
    System.out.println("Error: " + e.getMessage());
    
}
  return con;      
}
    public static void cerrarConexion(){
        if(con!=null){
        try{
         con.close();
        }catch(SQLException e){
            System.out.println("no se pudo cerrar la conexion");
        }
    }else{
            System.out.println("La conexion esta cerrada");
        }
}
}