/* Philip Kubiak
 * Assignment 2 Java OOP
 * CIS 4160 FMWA
 * ChangeRevolver will have user decide whether they wish to count change or make change, and use the appropriate class to do so.
 * Will use setter functions after prompting user to enter values, and call a different method to calculate depending on class.
 * No use for constructor this time, as user will always be prompted for values in the main method of ChangeRevolver.
 * Please see screenshots in folder in project.
 */
package money;
import java.util.Scanner;
public class ChangeRevolver {
	public static void main(String[] args) {
		System.out.println("Hello!\nIf you would like to count change, type 'count'."
				+ "\nIf you would like to make change, type 'make'."
				+ "\nIf you would like to quit, type anything else.");
		Scanner scanner = new Scanner(System.in);
		String input = scanner.next(); // this will decide what the user wishes to do
		if (input.equals("count") || input.equals("Count") || input.equals("COUNT")){
			CountChange count = new CountChange(); // we will make a new variable of CountChange class
			System.out.println("Enter number of quarters.");
			count.setQuarters(scanner.nextInt()); // We'll use nextInt() method to ensure user enters whole numbers of coins.
			System.out.println("Enter number of dimes.");
			count.setDimes(scanner.nextInt());
			System.out.println("Enter number of nickels.");
			count.setNickels(scanner.nextInt());			
			System.out.println("Enter number of pennies.");
			count.setPennies(scanner.nextInt());
			double total = count.countTotal(); // call method to calculate total dollar amount using coin values
			System.out.println("Your total is $" + total + "\nThank you.");
		}
		else if (input.equals("make") || input.equals("Make") || input.equals("MAKE")){
			MakeChange make = new MakeChange(); // we will make a new variable of MakeChange class
			System.out.println("Enter an amount in cents.");
			make.setMoney(scanner.nextInt()); // again, use nextInt() for input validation
			make.showAmounts();
		}
		else{
			System.out.println("Goodbye!");
		}
		scanner.close();
	}
}
