$command=Read-Host @' 
What would you like to do?
1. Start
2. Stop
3. Continue
5. Quit
Enter Choice
'@
switch ($command){
    '1'{'Starting'}
    '2'{'Stopping'}
    '3'{'Continuing'}
    '4'{'Quitting'}
    default {'Invalid Command'}
}
switch ($command){
    '1' {'Starting'}
    'start' {'Starting'}
    '2' {'Stopping'}
    'stop' {'Stopping'}
    '3' {'Continuing'}
    'continue' {'Continuing'}
    '4' {'Quitting'}
    'quit' {'Quitting'}
    default {'Invalid Command'}
}
switch -Wildcard ($command){
    '1' {'Starting'}
    's*' {'Starting'}
    '2' {'Stopping'}
    's*' {'Stopping'}
    '3' {'Continuing'}
    'c*' {'Continuing'}
    '4' {'Quitting'}
    'q*' {'Quitting'}
    default {'Invalid Command'}
}
switch -Wildcard ($command){
    '1' {'Starting'}
    'sta*' {'Starting'}
    '2' {'Stopping'}
    'sto*' {'Stopping'}
    '3' {'Continuing'}
    'c*' {'Continuing'}
    '4' {'Quitting'}
    'q*' {'Quitting'}
    default {'Invalid Command'}
}