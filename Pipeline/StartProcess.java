package de.stenschmidt.test;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class StartProcess {

	public static void main(String[] args) {
		try {
			String line;
			Process p = Runtime.getRuntime().exec(args[0]);
			
			BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));
			while ((line = input.readLine()) != null) {
				System.out.println(line);
			}
			input.close();
			
			System.out.printf("\nExitcode: %s\n", p.waitFor());
			
		} catch (Exception err) {
			err.printStackTrace();
		}

	}

}
