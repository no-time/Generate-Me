while ($true){

    #Declare Mouse positions for X and Y

    $Xposition= [System.Windows.Forms.Cursor]::Position.x

    $Yposition= [System.Windows.Forms.Cursor]::Position.y

   

    #Time Counter/StopWatch

    $Timer= New-Object-TypeName System.Diagnostics.Stopwatch

   

    #PseudoRandom Number

    $PseudoRandom= get-random-Minimum 13371-Maximum 17337

   

   

    #Message for User

    $UserInput= Read-Host "How many characters would you like this to be?"

    Read-Host "Please Press Enter. Then move your mouse around. `

    Once complete you will be notified"

   

    #loop counter

    $count= 0

 

    #Start StopWatch

    $Timer.Start()

 

    #Create array for number codes

    $LongNumberStr=@()

 

    #Start count off at zero, once it reaches $PseudoRandom number it will end

    while ($count -le $PseudoRandom)

    {

        #Use other pseudorandom numbers to add variability to mouse movement

        $PseudoRandom2= get-random-Minimum 133 -Maximum 733

   

        #Temporary variable grabbing mouse movement and adding end number randomly

        $large= 0

        $large= $Xposition+ $Yposition+$PseudoRandom2

 

        #PseudoRandom for more variability

        $PseudoRandom3= get-random -Minimum 1 -maximum 50

   

        #Dividing to make number more manageable

        $large= $large/$PseudoRandom3

 

        #Removing trailing decimals

        $large= [math]::floor($large)

 

        #Resetting mouse location for capture

        $Xposition= [System.Windows.Forms.Cursor]::Position.x

        $Yposition= [System.Windows.Forms.Cursor]::Position.y

 

        #Increasing loop counter

        $count++

 

        #Create current stopwatch time variable

        $Salt= $Timer.ElapsedTicks

 

        #Making variable to generate large string from previous steps

        $LongNumberStr+= ([math]::floor($large+$Salt/$count/100))

    }

 

    #Reset if program will be run again

    $count= 0

 

    #Stop Timer/Stopwatch

    $Timer.Stop()

 

    #Cycle through array concatenating 0x to the number for Unicode characters

    foreach ($number in$LongNumberStr){

        $z= "0x"+$number

   

        #Creating variable then changing to character from integer of z variable

        $charactersCoded= $charactersCoded+([char][int]$z)

        }

 

    #Replacing Newlines

    $charactersCoded= $charactersCoded-replace "`t|`n|`r",""

 

    #Use temp file for Ascii encoding (CWD)

    $charactersCoded| out-file -Encoding ascii.\test.txt

    #Change temp file to variable

    $document= Get-Content.\test.txt

    #Remove temp file from CWD

    rm .\test.txt

    #Remove all the ? -- for Unicode characters over ASCII limit

    $document= $document-replace "\?",""

    #Use random starting place and the user's requested length

    $document.Substring($PseudoRandom,$UserInput)

   

    #Exit Question

    $Exitprompt= Read-Host "Would you like to quit?

    [y] to quit"

    if ($Exitprompt -eq"y"){break}

    else{}

  
}
