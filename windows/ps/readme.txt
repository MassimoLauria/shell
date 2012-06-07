
Per eseguire gli script e configurare la shell è necessario fare le seguenti cose:

- eseguire il comando "Set-ExecutionPolicy remoteSigned" in una p[owershell di amministratore.

- copiare lo script di avvio "profile.ps1" nella cartella ~/Documenti/WindowsPowerShell

Per costruire una shell customizzata con il tema zenburn, eseguire
> Import-Module ZenburnPowerShell
> New-ZenburnPowerShell "nome della shell"

E copiare il link "nome della shell" dove si preferisce.
