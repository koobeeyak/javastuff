/* by Philip Kubiak
 */
package money;
public class CountChange { 
	private double quarters, dimes, nickels, pennies;
	public double getQuarters() {
		return quarters;
	}
	public void setQuarters(double quarters) {
		this.quarters = quarters;
	}
	public double getDimes() {
		return dimes;
	}
	public void setDimes(double dimes) {
		this.dimes = dimes;
	}
	public double getNickels() {
		return nickels;
	}
	public void setNickels(double nickels) {
		this.nickels = nickels;
	}
	public double getPennies() {
		return pennies;
	}
	public void setPennies(double pennies) {
		this.pennies = pennies;
	}
	public double countTotal() { // our method that will calculate total dollar amount
		double total = 0; // set a variable to keep count of total amount
		total += quarters * .25; // multiply each amount by their value in dollars
		total += dimes * .1; // use += to add to total
		total += nickels * .05;
		total += pennies * .01;
		return total;
	} // end main
} // end class