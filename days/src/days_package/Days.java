/* Philip Kubiak
 * Number of days in month assignment
 * -Will prompt user to enter first three letters of month.
 * -Will check to ensure user has entered three characters.
 * -Will compare input to values in array to determine how many days in the month.
 * -If February, will prompt user for year, then determine whether or not this is a leap year.
 * -Testing array for a certain value
 */
package days_package;
import java.util.*;

public class Days {

	public static void main(String[] args) {
		// use arrays to hold months with 31 days or 30 days
		String[] thirtyOneDays = new String[] {"JAN","MAR","MAY","JUL","AUG","OCT","DEC"};
		String[] thirtyDays = new String[] {"APR","JUN","SEP","NOV"};
		String february = "FEB"; // only other month is February
		Scanner scanner = new Scanner(System.in);
		System.out.println("Enter the first three letters of a month to find out how many days it has.");
		String month = scanner.nextLine().toUpperCase(); // convert input to upper case for consistency
		// let's validate the users input to be sure three characters are being entered
		while (month.length() != 3){
			System.out.println("Please enter the first three letters only.");
			month = scanner.nextLine().toUpperCase();
		}
		// contains() is a built in method to check contents of a list.
		// we will use aslist() method of Arrays API to return our arrays as a fixed list,
		// then check whether user's month can be found.
		if (Arrays.asList(thirtyOneDays).contains(month)){
			System.out.println(month + " has 31 days.");
		}
		else if (Arrays.asList(thirtyDays).contains(month)){
			System.out.println(month + " has 30 days.");
		}
		else if (month.equals(february)){
			System.out.println("To find out number of days in " + month + ", enter the year.");
			int year = scanner.nextInt();
			// rule for leap years: year must be divisible by four, cannot be divisible by 100, with the exception
			// of being divisible by 400
			if (year % 4 == 0 && year % 100 !=0 || year % 400 == 0){
				System.out.println(month + " in " + year + " has 29 days.");
			}
			else // is not a leap year
				System.out.println(month + " in " + year + " has 28 days.");
		}
		else // user's input cannot be matched to any month.
			System.out.println("Not a valid month."); 
		scanner.close(); //safety first
	}

}
