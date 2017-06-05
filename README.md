Author:	Joan Grau	

Creation Date: 03/06/2017

Current state: In progress

REASONS:

Ambisonics it's a very interesting theory which revolves around codifying the soundfield using a complex and complete mathematical theory, which has many interesting aplications and implications. 
As this theory has a lot of points from where it can be taken on, I want to try to implement this theory and the capabilities of it, in a serie of distributed functions that work separately or together depending on our needs.


OBJECTIVE:

Create and implement a list of basic functions to work with Ambisonics with Matlab.
At the moment this library only includes up to first order Ambisonics, in the future I may extend this functions to support Higher Order Ambisonics.


FOLDERS:

  - Functions: Folder containing all the functions implemented
  
  
  

CURRENT FUNCTIONS:

(All the functions are localized on the functions folder)

-  	ambisonics-B-format:
    - Creates an ambisonic 4 channel track from an imput signal and directionality parameters.
    
-   ambis_a_b_converter
    - Converts an a-format ambisonic signal to b-format 

-   ambis-uhj-format
    - Series of functions that allows us to code and decode UHJ format (also known as c-format)
    
    
    
    
    
    
