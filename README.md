# SALIDO iOS Challenge
This challenge is intended to get a better idea of a SALIDO candidate's coding style and development process. There is no hard time limit, but we ask that you send in your solution promptly.

Please feel free to use the developer reviewing your work as a resource. If any points seem vague or need clarifying, they will be there to help.

## Submission Instructions

1. Clone this repo and complete the challenge
2. Send a patch file of your solution to your interviewer via email

## Expectations
1. Complete the challenge according to the Challenge Instructions below.
1. Post your solution in a Github repo. Be sure to include a README.
1. Send a link to your solution to challenge-accepted@salido.com.

## Context
Imagine SALIDO has expanded its reach into the wine industry with the new "SALIDO Wine Club". We need to source product data from the wine.com API (http://api.wine.com) and load it into our own database of wine products.

## Requirements
1. Upon app start, the user should be prompted to sign in using a pin or to create a new employee
	- A user should have (at minimum) the following attributes:
		1. a pin code (numeric values only, required)
		2. a first name (required)
		3. a last name (required)
		4. a valid email address (optional)
	- An error prompt must appear if an invalid pin is entered (not the right format or isn't assigned to anyone)
	- All employees must be unique (first name duplicates are allowed, but pin, last name, and email addresses must be unique)
2. The user should be able to search for their pin from the log in screen if they've forgotten it.
	- The user should be asked to enter the email for the employee they wish to find a pin for.
	- If the email is not found in the database, inform the user.
	- If the email is found, display the user's pin.
	- The user should be able to:
		- Sort by name
		- Filter by category (once filtered, user should be able to sort the list by name)
	- The items in the list presented should display an image of the item and the item name (if no image is given, display nothing).
	- If the API is unreachable (no internet) an error notification should be displayed on every screen. Attempts to reach the API present an error message.
	- The user should be able to quickly add an item to their cart from this screen, without entering the item's detail screen.
3. Upon logging in, the user should be presented with a list of wines sourced from the wine.com API
4. Upon selecting an item from the list, the user should be taken to an item detail screen.
	- The item detail screen should display an image of the item (if it exists) and the item's name
	- The item detail screen should display the item's description as returned from the API. Otherwise, placeholder information must be provided.
	- The item detail screen should allow the user to add the item to their shopping cart and set the quantity.
5. Upon moving to the shopping cart screen, the user should be shown a list of items that were selected.
	- Items in the list should display the item image, item name, and quantity bought
	- Items should be displayed in the order they were added to the cart.
	- The total of all item quantities should be present somewhere on the screen.
	- The screen should allow the user to return to the main catalogue of items.
	- The user should be allowed to remove items from the cart.
	- The item detail screen should also be accessible from the shopping cart screen by selecting an item.
	- No item in the cart can have a quantity of 0.
	- If multiple instances of the same item are added, but at different points, the item should appear in the position that the first instance was added, but the quantity should be grouped. For example:
		- Item A was added with quantity 1.
		- Item B was added with quantity 2.
		- Another instance of item A was added, but with a quantity of 4.
		- The expected outcome is:
			- Item A, Qty 5
			- Item B, Qty 2
6. Upon checking out, the user should be presented with a confirmation or "Thank You" screen as well as the option to start a new order.
7. The user should be able to log out at any point in time.
8. The user should be able to access their shopping cart at any time.
9. The user should be allowed to view a list of all employees.
	- Display the employee's hiring date and the amount of items in their cart, if any.

## Other Notes
- Your application must be written in Objective-C
- You do not need to:
	- Save an order or session if the app enters the background. If the user presses the home button, you can just log them out and present the login screen when the app is launched again.
	- Handle payment. Assume all items are free.
	- Have fancy UI. You can make the interface as barebones as you'd like.
	- Account for screen rotation.
	- Account for iPhone displays. Focus on iPads.
- You can:
	- Use (free) 3rd party frameworks and libraries, if needed.

- While it isn't required, it is recommended that you write simple tests for your validations.

- Evaluation:
	We are judging your work based on the following criteria:
	- Did you complete all of the base requirements?
	- Did you follow standard coding practices and use an appropriate programming paradigm for iOS development?
	- Did you properly submit the project?
	- Did you use iOS and 3rd party frameworks in an appropriate way?
	- Did your program crash?
	- Is your code "self-documenting"?
	- Is the data retrieved from the API/created by the user modeled cleanly with the appropriate relationships?
