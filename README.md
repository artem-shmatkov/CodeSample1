# CodeSample1

Task:

- Project should be stored in a public Git repository (Github / Gitlab)
- Project should not have third-party code or components that are missing by default in iOS (Exception - allowed to use Realm / Sqlite)
- Project must support iOS 12
- Application should correctly display on screens 4.7 ”and above (you could not support the old SE)
- Application must be localized (English and Russian)
- There should be no memory leaks in the project
- Show the upper panel on both screens with the name of the current screen and the lower menu (TabBar) with two buttons: List and Service

List screen:
Display a table of editable items: 
- Display each item as a picture icon (two types for all items) + item name + checkbox (if selected, the icon is of the 1st type, otherwise - of the 2nd type)
- Add the "Add" button, which opens a screen with the form for adding a new item (the form with one field - Item Name): At the bottom there are two buttons: Done (add item) and Revert (cancel adding) - by pressing, you return to the list, by clicking on the Back button displays Alert with the offer to save the item, if the Item Name field is filled, if not, returns to the list without Alert
- When clicking on an item in the list, open the editing form (identical to the form for adding a new item)
- Implement swipe menu: left is the edit button (Edit) - open the editing form, as in the previous paragraph. The delete button on the right is to delete a line from the list, also deletion works with a long swipe of the cell
- Note: the application must remember all changes made to the list (adding new items and editing existing ones) - i.e. after restarting the application, everything should be as it was before the application was closed.

Service Screen:
- Get XML data - https://www.w3schools.com/xml/cd_catalog.xml
- Display the data in a table in a convenient form (of your choice - the main thing is to be readable).
- Download in a separate stream.
- Visualize the loading process.



Copyrights:

List icon from https://www.flaticon.com/authors/kirill-kazachek

Service icon from https://www.flaticon.com/authors/freepik

Bulb icon from https://www.flaticon.com/authors/good-ware
