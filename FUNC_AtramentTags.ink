/*
Markup 	Description

[img]path/to/image.jpg[/img] 
    Display inline image.

[button=function]Text[/button]
[button onclick=function]Text[/button]

Display button, call a function when clicked. If function returns text, it will be displayed as a new overlay content. If not, existing overlay content will be updated.

Attributes:
    onclick=function function to be called when clicked.
    disabled=true disables the button
    bordered=false hide button borders

[link=target choice text]Text[/link] 	
    Creates a link. When clicked, the target choice is activated, and game continues.

[progress value={variable}]Inner text[/progress] 

Displays progress bar.
Attributes:
    value=x current progressbar value
    min=x minimal progressbar value
    max=x maximal progressbar value
    style=accent highlight progressbar with accent theme color


[input var=variable]
    Input element, sets value of given variable. Default value of this field is read from the same variable. Disabled on inactive scenes.
Attributes:
    var=n variable name to change
    type=number input type. Possible values: text, number.
    placeholder=text placeholder text

[spoiler]text[/spoiler] 	Hidden text. Clicking it toggles text visibility.

[info]text[/info] 	Display text as an information block. Since this is a block element, it is recommended to use it on a whole paragraph.
    Attributes:
    font=system use system font
    side=n add color to the left infobox side. Possible values: highlight, accent.

[banner]text[/banner] 	Display text as an banner block. Since this is a block element, it is recommended to use it on a whole paragraph.
    Attributes:
    style=accent use accent color
    allcaps=true display text in all capitals

[font=Courier New]text[/font] 	Applies font to the text.

[highlight]text[/highlight]

[highlight color=yellow bgcolor=black]Text[/highlight] 	Highlights text with accent color.
    Optional parameters bgcolor and color allow to set both background and foreground color for text.
*/