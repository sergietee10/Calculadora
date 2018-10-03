package net.daw.calculadora;

import java.io.IOException;

import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;


/**
 * Servlet implementation class calculadora
 */
public class calculadora extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public calculadora() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest( request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	protected boolean processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		DecimalFormat df = new DecimalFormat("#.##");
		Gson gSon = new Gson();
		String stnum2 = request.getParameter("num2").trim();
		String stnum1 = request.getParameter("num1").trim();
		String er = "-?[0-9]+([.][0-9]+)?";
		String operador = request.getParameter("operador").trim();
		double resul = 0;
		
try {
	if (stnum1.matches(er) && stnum2.matches(er)) {
        Double num1 = Double.parseDouble(stnum1);
        Double num2 = Double.parseDouble(stnum2);
        switch (operador) {
            case "suma":
                resul = num1 + num2;
                break;
            case "resta":
                resul = num1 - num2;
                break;
            case "multiplicacion":
                resul = num1 * num2;
                break;
            case "division":
                if (num1 == 0 || num2 == 0) {
                    throw new NumberFormatException();
                } else {
                    resul = num1 / num2;
                    break;
                }
        }

        String strJson = gSon.toJson(df.format(resul));
        out.print(strJson);
         } else {
             throw new IllegalArgumentException();
         }
     } catch (NumberFormatException nfe) {
         response.setStatus(500);
         String error = "No puedes dividir entre 0.";
         String strJson = gSon.toJson(error);
         out.print(strJson);
     } catch (IllegalArgumentException iae) {
         response.setStatus(500);
         String error;
         if (stnum2.equals("") || stnum1.equals("")) {
             error = "Rellene los campos vacíos.";
         } else {
             error = "Introduzca números enteros o decimales con '.'.";
         }
         String strJson = gSon.toJson(error);
         out.print(strJson);
     }
return false;
 }
	
}
