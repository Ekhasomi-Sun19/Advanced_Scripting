$command = Read-Host @"
What would you like to do?
1. Start
2. Stop
3. Continue
4. Quit
Enter choice
"@

switch -Wildcard ($command) {
    '1' {'Starting'}
    'start' {'Starting'}
    's*' {'Starting'}
    'sta*' {'Starting'}
    '2' {'Stopping'}
    'stop' {'Stopping'}
    'sto*' {'Stopping'}
    '3' {'Continuing'}
    'continue' {'Continuing'}
    'c*' {'Continuing'}
    '4' {'Quitting'}
    'quit' {'Quitting'}
    'q*' {'Quitting'}
    default {'Invalid command'}
}
