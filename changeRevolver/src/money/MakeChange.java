/* by Daniel Tsekhanskiy
 */
package money;
public class MakeChange {
    private double money;
	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
		this.money = money;
	}
	public void showAmounts() {
    	//Initialize variables
        int quarter, dime, nickel, penny = 0;
        quarter = (int)(money / 25);
        money = money % 25;
        dime = (int)(money / 10);
        money = money % 10;
        nickel = (int)(money / 5);
        money = money % 5;
        penny = (int)(money / 1);
        //show output, using println to force new line after each output and string concatenation to print variable and string on same line.
            System.out.println("Quarters: " + quarter);
            System.out.println("Dimes: " + dime);
            System.out.println("Nickels: " + nickel);
            System.out.println("Pennies: " + penny);     
            System.out.println("Thank you.");
    }
}