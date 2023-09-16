Damit die Aufgaben funktionieren und man auch Belohnungen kriegt müssen zuerst bestimmte "Trigger" in ein paar Scripts hinzugefügt werden

1. Gehe in den Ordner "esx_vehicleshop" und dann unter dem Ordner "client" in die "main.lua". Da gehst du in die Zeile 182 und fügst dort folgendes ein:
   TriggerServerEvent('battlepass:addQuest', 7)

2. Gehe in das Banking Script was du benutzt und dann entweder in die "client.lua" oder zuerst in den Ordner "client" und dann die Datei "main.lua" öffnen.
   Dort suchst du dann nach "transfer" und fügst den folgenden Trigger ein:
   TriggerServerEvent('battlepass:addQuest', 8)

   Danach suchst du nach "deposit" und fügst dort folgendes ein:
   TriggerServerEvent('battlepass:addQuest', 5)

3. Gehe in das Shop Script was du benutzt und dann entweder in die "client.lua" oder zuerst in den Ordner "client" und dann die Datei "main.lua" öffnen.
   Dort suchst du dann nach "buy" und fügst den folgenden Trigger ein:
   TriggerServerEvent('battlepass:addQuest', 4)

4. Gehe in den Ordner "dpemotes" und dann unter dem Ordner "Client" in die "Syncing.lua". Dann gehst du in die Zeile 71 und fügst folgenden Trigger ein:
   TriggerServerEvent('battlepass:addQuest', 2)

5. Gehe in den Ordner "esx_clotheshop" und dann unter dem Ordner "client" in die "main.lua". Dann gehst du in die Zeile 58 und fügst folgenden Trigger ein:
   TriggerServerEvent('battlepass:addQuest', 10)

