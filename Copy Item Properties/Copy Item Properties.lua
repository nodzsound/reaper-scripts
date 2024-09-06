@description Copy Item Properties
@version 1.0.0
@author nodzsound
@links 
     Website https://nico-dilz.com
     Instagram https://www.instagram.com/nodzsound/
     LinkedIn https://www.linkedin.com/in/nodzsound/    
@about
 This package offers scripts to copy and paste the item properties from one item to
 another. Supported properties are: length, pitch, playrate, fade-in, fade-out.
 You can copy properties from multiple items to multiple items. Here is how it works: 
 1) num items to copy from = num items to paste to: This will result in a 1:1 transfer.
 2) num items to copy from < num items to paste to: This will cycle through the items
 to copy from until the last item is reached. Then it will start with item 1 again. 
 Example: 
 Copy From: 1|2|3|1|2|3|
 Copy to:   1|2|3|4|5|6|
 3) num items to copy from > num items to paste to: Same as 2, but not all items to
 copy from will be used. 
 Example:
 Copy From: 1|2|3|4|
 Copy To:   1|2|    
 I hopy that you find this package helpful. To report any bugs, please mail to: 
 reapack@nico-dilz.com 
@provides
    [main] nodzsound-Copy_Item_Properties.lua
    [main] nodzsound-Paste_Item_Properties_ALL.lua
    [nomain] memory/memory.txt
@changelog 
     Created First Version of this script
